import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stuverse_ai/app/models/agent.dart';
import 'package:stuverse_ai/features/chat/model/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit()
      : super(
          ChatState(agent: agentsList[0]),
        );

  String result = '';

  void setAgent(Agent agent) {
    emit(
      state.copyWith(
        agent: agent,
      ),
    );
  }

  void addMessage(String message,
      {MessageAuthor author = MessageAuthor.User,
      MessageType type = MessageType.Text,
      String? image}) {
    emit(
      state.copyWith(
        messages: [
          ...state.messages,
          Message(
            text: message,
            author: author,
            type: type,
            image: image,
          ),
        ],
      ),
    );
  }

  void sendMessage(
      {required String message, required Agent agent, XFile? image}) async {
    try {
      result = '';
      emit(state.copyWith(isLoading: true));
      Uint8List? imageBytes = null;
      if (image != null) {
        imageBytes = await image.readAsBytes();
      }
      addMessage(
        message,
        author: MessageAuthor.User,
        type: imageBytes != null ? MessageType.Image : MessageType.Text,
        image: image?.path,
      );

      addMessage(
        "....💬",
        author: MessageAuthor.Agent,
      );

      final gemini = Gemini.instance; // Import 'Gemini' class
      gemini
          .streamGenerateContent(agent.promptContext + message,
              images: imageBytes != null ? [imageBytes] : null,
              generationConfig: GenerationConfig(
                // maxOutputTokens: widget.agent.tokenLimit,

                temperature: agent.temperature,
              ))
          .listen((value) {
        result += value.output ?? '';
        state.messages.removeLast();
        addMessage(
          result,
          author: MessageAuthor.Agent,
        );
      }, onDone: () {
        emit(
            state.copyWith(isLoading: false)); // Replace 'setState' with 'emit'
      });
    } catch (e) {
      print(e);
      emit(state.copyWith(isLoading: false)); // Replace 'setState' with 'emit'
    }
  }
}

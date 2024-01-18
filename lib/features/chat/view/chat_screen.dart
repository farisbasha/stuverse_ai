import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse_ai/features/chat/cubit/chat_cubit.dart';
import 'package:stuverse_ai/features/chat/widgets/footer_field.dart';
import 'package:stuverse_ai/features/chat/widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${state.agent.name} Chat'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(state.agent.image),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          state.agent.description,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 20.0),
                        ...state.messages
                            .map((message) => MessageBubble(
                                  message: message,
                                ))
                            .toList(),
                        SizedBox(height: 8.0),
                        if (state.isLoading) ...[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(left: 10.0),
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          SizedBox(height: 8.0),
                        ],
                      ],
                    ),
                  ),
                  const FooterTextField()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

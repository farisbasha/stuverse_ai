import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:stuverse_ai/features/chat/model/message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
  });
  final Message message;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      shadowColor: Colors.transparent,
      clipper: ChatBubbleClipper1(
          type: message.author == MessageAuthor.User
              ? BubbleType.sendBubble
              : BubbleType.receiverBubble),
      alignment: message.author == MessageAuthor.User
          ? Alignment.topRight
          : Alignment.topLeft,
      margin: EdgeInsets.only(top: 20),
      backGroundColor: message.author == MessageAuthor.User
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.secondaryContainer,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(message.image!),
                  fit: BoxFit.contain,
                ),
              ),
            MarkdownBody(
                selectable: true,
                styleSheet: MarkdownStyleSheet(
                  code: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      backgroundColor: Colors.black),
                  codeblockPadding: const EdgeInsets.all(8),
                  codeblockDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.black,
                  ),
                ),
                data: message.text),
          ],
        ),
      ),
    );
  }
}

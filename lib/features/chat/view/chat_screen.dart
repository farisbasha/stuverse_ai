import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:stuverse_ai/app/models/agent.dart';
import 'package:stuverse_ai/features/chat/model/message.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.agent});
  final Agent agent;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> messages = [];
  final TextEditingController _messageFieldController = TextEditingController();

  void addMessage(String message,
      {MessageAuthor author = MessageAuthor.User,
      MessageType type = MessageType.Text}) {
    setState(() {
      messages.add(
        Message(
          text: message,
          author: author,
          type: type,
        ),
      );
    });
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.agent.name} Chat'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.agent.image),
                      radius: 40.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      widget.agent.description,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 20.0),
                    ...messages
                        .map((message) => ChatBubble(
                              shadowColor: Colors.transparent,
                              clipper: ChatBubbleClipper1(
                                  type: message.author == MessageAuthor.User
                                      ? BubbleType.sendBubble
                                      : BubbleType.receiverBubble),
                              alignment: message.author == MessageAuthor.User
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              margin: EdgeInsets.only(top: 20),
                              backGroundColor:
                                  message.author == MessageAuthor.User
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primaryContainer
                                      : Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.7,
                                ),
                                child: MarkdownBody(
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
                              ),
                            ))
                        .toList(),
                    SizedBox(height: 8.0),
                    if (_isLoading) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                        ),
                        controller: _messageFieldController,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        try {
                          String message = _messageFieldController.text;
                          addMessage(
                            message,
                            author: MessageAuthor.User,
                          );
                          _messageFieldController.clear();
                          setState(() {
                            _isLoading = true;
                          });
                          final gemini = Gemini.instance;
                          final value = await gemini
                              .text(widget.agent.promptContext + message);

                          addMessage(
                            value?.output ?? "No response",
                            author: MessageAuthor.Agent,
                          );
                        } catch (e) {
                          print(e);
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

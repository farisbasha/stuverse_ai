import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:stuverse_ai/app/models/agent.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.agent});
  final Agent agent;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> messages = [];
  final TextEditingController _messageFieldController = TextEditingController();

  void addMessage(String message) {
    setState(() {
      messages.add(message);
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
        child: Column(
          children: [
            //image
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.agent.image),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.agent.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          widget.agent.description,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ...messages
                      .map(
                        (message) => ListTile(
                          title: MarkdownBody(data: message),
                        ),
                      )
                      .toList(),
                  if (_isLoading) const LinearProgressIndicator()
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
                        addMessage(message);
                        _messageFieldController.clear();
                        setState(() {
                          _isLoading = true;
                        });
                        final gemini = Gemini.instance;
                        final value = await gemini
                            .text(widget.agent.promptContext + message);

                        addMessage(value?.output ?? "No response");
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse_ai/app/models/agent.dart';
import 'package:stuverse_ai/app/utils/common_utils.dart';
import 'package:stuverse_ai/app/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stuverse AI'),
        actions: [
          //switch theme
          IconButton(
            onPressed: () {
              CommonUtils.changeTheme(context);
            },
            icon: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (final agent in agentsList)
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(agent.image),
                  ),
                  title: Text(agent.name),
                  subtitle: Text(agent.description),
                  onTap: () {
                    context.push(Routes.chatScreenName, extra: agent.id);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

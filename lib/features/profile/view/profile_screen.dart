import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse_ai/app/utils/common_utils.dart';
import 'package:stuverse_ai/app/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
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
      body: Center(
        child: Text(
            'Profile and Premium Features will be available here,\nIt will be available in the next update.'),
      ),
    );
  }
}

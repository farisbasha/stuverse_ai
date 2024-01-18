import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              if (AdaptiveTheme.of(context).mode.isDark) {
                AdaptiveTheme.of(context).setLight();
              } else {
                AdaptiveTheme.of(context).setDark();
              }
            },
            icon: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: const Text('Profile Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go(Routes.homeScreenName);
              },
              child: const Text('Show snack bar'),
            ),
          ],
        ),
      ),
    );
  }
}

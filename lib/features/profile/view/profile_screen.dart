import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse_ai/app/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stuverse_ai/app/models/agent.dart';
import 'package:stuverse_ai/app/utils/constants.dart';
import 'package:stuverse_ai/app/view/main_screen.dart';
import 'package:stuverse_ai/app/view/not_found_screen.dart';
import 'package:stuverse_ai/features/chat/view/chat_screen.dart';
import 'package:stuverse_ai/features/home/view/home_screen.dart';
import 'package:stuverse_ai/features/profile/view/profile_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: Routes.homeScreenName,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.homeScreenName,
              builder: (context, state) => HomeScreen(),
            ),
          ]),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profileScreenName,
                builder: (context, state) => ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Routes.chatScreenName,
        builder: (context, state) => ChatScreen(
          agent: agentsList.firstWhere(
            (agent) => agent.id == state.extra as int,
          ),
        ),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );

  static GoRouter get router => _router;
}

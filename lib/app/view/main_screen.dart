import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({required this.navigationShell, Key? key})
      : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stuverse AI'),
      ),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(label: 'Section A', icon: Icon(Icons.home)),
          NavigationDestination(label: 'Section B', icon: Icon(Icons.settings)),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}

class NamedNavigationBarItemWidget extends BottomNavigationBarItem {
  final String initialLocation;

  const NamedNavigationBarItemWidget(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);
}

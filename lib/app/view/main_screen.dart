import 'package:flutter/material.dart';
import 'package:logman/logman.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({required this.navigationShell, Key? key})
      : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Logman.instance.attachOverlay(
        context: context,
        //  debugPage: // Your optional debug page,
        //  button: // Your optional custom button,
      );
    });
  }

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(label: 'Agents', icon: Icon(Icons.message)),
          NavigationDestination(
              label: 'Profile', icon: Icon(Icons.account_box)),
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

import 'package:demo_flutter_ex1/datas/notifiers.dart';
import 'package:flutter/material.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifiers,
      builder: (BuildContext context, dynamic selectedPage, Widget? child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.article), label: 'Processing'),
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
          onDestinationSelected: (int value) {
            selectedPageNotifiers.value = value;
          },
          selectedIndex:  selectedPage,
        );
      },
    );
  }
}

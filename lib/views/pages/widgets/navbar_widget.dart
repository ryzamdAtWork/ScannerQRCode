import 'package:flutter/material.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  int _getSelectedIndex(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name;
    switch (routeName) {
      case '/process':
        return 0;
      case '/dashboard':
        return 1;
      case '/personal':
        return 2;
      default:
        return 1; // Mặc định là Home/Dashboard nếu không xác định được route
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getSelectedIndex(context);
    return NavigationBar(
      destinations: const [
        NavigationDestination(icon: Icon(Icons.article), label: 'Processing'),
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: (int value) {
        // Nếu màn hình hiện tại khác với màn hình được chọn, chuyển hướng.
        if (value == 0 && ModalRoute.of(context)?.settings.name != '/process') {
          Navigator.pushReplacementNamed(context, '/process');
        } else if (value == 1 && ModalRoute.of(context)?.settings.name != '/dashboard') {
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else if (value == 2 && ModalRoute.of(context)?.settings.name != '/personal') {
          Navigator.pushReplacementNamed(context, '/personal');
        }
      },
    );
  }
}

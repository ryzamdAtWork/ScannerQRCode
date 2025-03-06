import 'package:demo_flutter_ex1/datas/notifiers.dart';
import 'package:demo_flutter_ex1/views/pages/dashboard/dash_board_screen.dart';
import 'package:demo_flutter_ex1/views/pages/dashboard/temporary/temporary_screen.dart';
import 'package:demo_flutter_ex1/views/pages/login/login_screen.dart';
import 'package:demo_flutter_ex1/views/widget_tree.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// App gốc với cấu hình theme (có thể thêm font, màu sắc đặc trưng từ design Figma)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: isDarkModeNotifiers, builder: (context, isDarkMode, child) {
      return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/widgetTree': (context) => const WidgetTreeScreen(),
        '/dashboard': (context) => const DashBoardScreen(),
        '/temporary': (context) => const TemporaryScreen(), //test commit
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Brunches-RoughSlanted',
        primarySwatch: Colors.blue,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
    );
    },);
  }
}

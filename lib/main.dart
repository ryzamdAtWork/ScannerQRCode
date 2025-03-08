import 'package:demo_flutter_ex1/views/pages/dashboard/dash_board_screen.dart';
import 'package:demo_flutter_ex1/views/pages/dashboard/outbound/out_bound_screen.dart';
import 'package:demo_flutter_ex1/views/pages/dashboard/temporary/temporary_screen.dart';
import 'package:demo_flutter_ex1/views/pages/login/login_screen.dart';
import 'package:demo_flutter_ex1/views/pages/personal/personal_screen.dart';
import 'package:demo_flutter_ex1/views/pages/process/process_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashBoardScreen(),
        '/process' : (context) => const ProcessScreen(),
        '/personal' : (context) => const PersonalScreen(),
        '/outbound' : (context) => const OutBoundScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/temporary') {
          return MaterialPageRoute(
            builder: (context) => const TemporaryScreen(),
          );
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Brunches-RoughSlanted',
        primarySwatch: Colors.blue,
      ),
    );
  }
}

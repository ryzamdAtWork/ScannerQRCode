import 'package:demo_flutter_ex1/views/pages/dashboard/dashboard_component_widgets.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "DASH BOARD",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      // Nếu Figma có Navigation Drawer hoặc Bottom Nav Bar, bạn thêm vào
      // drawer: Drawer(...),
      // bottomNavigationBar: ...
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardWidgets.buildHeader(context),

                const SizedBox(height: 24),

                DashboardWidgets.buildStatisticCards(context),

                const SizedBox(height: 24),

                DashboardWidgets.buildFeatureTable(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:demo_flutter_ex1/views/pages/dashboard/dash_board_component_widgets.dart';
import 'package:demo_flutter_ex1/views/pages/widgets/general_screen.dart';
import 'package:demo_flutter_ex1/views/pages/widgets/navbar_widget.dart';
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


    return GeneralScreenScaffold(
      title: Text(
          "DASH BOARD",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      isSubScreen: false,
      showBackButton: false,
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
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
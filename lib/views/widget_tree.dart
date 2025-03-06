import 'package:demo_flutter_ex1/datas/notifiers.dart';
import 'package:demo_flutter_ex1/views/pages/dashboard/dash_board_screen.dart';
import 'package:demo_flutter_ex1/views/pages/personal/personal_screen.dart';
import 'package:demo_flutter_ex1/views/pages/process/process_screen.dart';
import 'package:demo_flutter_ex1/views/pages/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';

List<Widget> screens = [ProcessScreen(), DashBoardScreen(), PersonalScreen()];

class WidgetTreeScreen extends StatelessWidget {
  const WidgetTreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('HOME'),
      //   actions: [
      //     IconButton(onPressed: (){
      //       isDarkModeNotifiers.value = !isDarkModeNotifiers.value;
      //     }, icon: ValueListenableBuilder(
      //       valueListenable:  isDarkModeNotifiers,
      //       builder: (BuildContext context, dynamic isDarkMode, Widget? child) {
      //         return  isDarkMode ? Icon(Icons.light_mode) : Icon(Icons.dark_mode);
      //       },
      //     )),
      //   ],
      // ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifiers,
        builder: (BuildContext context, dynamic selectedPage, Widget? child) {
          return screens.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: NavbarWidget(),
        ),
    );
  }
}

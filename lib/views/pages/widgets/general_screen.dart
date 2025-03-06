import 'package:flutter/material.dart';

/// GeneralScreenScaffold là widget chung cho tất cả các màn hình,
/// nó tạo ra một Scaffold với AppBar có tiêu đề tùy chỉnh, nút back (nếu cần)
/// và các phần tùy chọn khác.
class GeneralScreenScaffold extends StatelessWidget {
  final Text? title;
  final bool showBackButton;
  final Widget body;
  final Widget? bottomNavigationBar;
  final AppBar? genAppBar;
  final List<Widget>? actions;

  const GeneralScreenScaffold({
    super.key,
    this.title,
    this.genAppBar,
    this.showBackButton = false,
    required this.body,
    this.bottomNavigationBar,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            showBackButton && Navigator.canPop(context)
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                )
                : null,
        title: title,
        centerTitle: true,
        automaticallyImplyLeading: showBackButton,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: actions,
      ),
      body: SafeArea(child: body),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

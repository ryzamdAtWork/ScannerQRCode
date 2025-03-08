import 'package:demo_flutter_ex1/views/pages/dashboard/outbound/out_bound_component_widgets.dart';
import 'package:demo_flutter_ex1/views/pages/dashboard/outbound/outbound_category_scan/outbound_category_scan_screen.dart';
import 'package:demo_flutter_ex1/views/pages/widgets/general_screen.dart';
import 'package:demo_flutter_ex1/views/pages/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';

class OutBoundScreen extends StatefulWidget {
  const OutBoundScreen({super.key});

  @override
  State<OutBoundScreen> createState() => _OutBoundScreenState();
}

class _OutBoundScreenState extends State<OutBoundScreen> {
  final GlobalKey<NavigatorState> _nestedNavKey = GlobalKey<NavigatorState>();

 String? _currentNestedRoute;

  void _handleBackButton() {
    final navigator = _nestedNavKey.currentState;
    if (navigator != null && navigator.canPop()) {
      navigator.pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScreenScaffold(
      title: const Text(
        "OUTBOUND CATEGORY",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      showBackButton: true,
      isSubScreen: false,
      actions: [
        if (_currentNestedRoute == '/outbound-scan')
          IconButton(
            icon: const Icon(Icons.directions_run), 
            onPressed: _handleBackButton,
          ),
      ],
      body: Navigator(
        key: _nestedNavKey,
        observers: [
          NestedNavigatorObserver(
            onNavigation: (Route<dynamic>? route) {
              // Sau khi push/pop xong (post frame callback), ta mới setState
              if (!mounted) return;
              if (route is MaterialPageRoute && route.settings.name != null) {
                final routeName = route.settings.name!;
                // Bỏ qua nếu routeName == '/' (của top-level) 
                // hoặc routeName == null
                if (routeName.startsWith('/outbound-')) {
                  setState(() {
                    _currentNestedRoute = routeName;
                  });
                } else {
                  // Nếu là route top-level hoặc popup => đặt _currentNestedRoute = null
                  setState(() {
                    _currentNestedRoute = null;
                  });
                }
              }
            },
          ),
        ],
        initialRoute: '/outbound-main',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/outbound-main':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => OutBoundComponentWidgets.buildSelectType(context),
              );
            case '/outbound-scan':
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => const OutboundCategoryScanScreen(),
              );
            default:
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => OutBoundComponentWidgets.buildSelectType(context),
              );
          }
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}

class NestedNavigatorObserver extends NavigatorObserver {
  final void Function(Route<dynamic>?) onNavigation;

  NestedNavigatorObserver({required this.onNavigation});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('didPush: ${route.settings.name}');
    super.didPush(route, previousRoute);
    // Gọi callback sau khi push hoàn tất
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onNavigation(route);
    });
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('didPop: ${route.settings.name} -> ${previousRoute?.settings.name}');
    super.didPop(route, previousRoute);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onNavigation(previousRoute);
    });
  }

  // Nếu cần, bạn có thể override didRemove, didReplace... tương tự
}

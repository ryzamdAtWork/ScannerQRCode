import 'package:demo_flutter_ex1/views/pages/widgets/general_screen.dart';
import 'package:demo_flutter_ex1/views/pages/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'temporary_business.dart';
import 'temporary_component_widgets.dart';

class TemporaryScreen extends StatefulWidget {
  const TemporaryScreen({super.key});

  @override
  State<TemporaryScreen> createState() => _TemporaryScreenState();
}

class _TemporaryScreenState extends State<TemporaryScreen>
    with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController();
  String barcodeValue = '';
  bool _torchEnabled = false;
  bool _hasScanned = false;
  bool _cameraActive = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Không tự động start camera; người dùng bật qua nút.
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_cameraActive) return;
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _controller.pause();
    } else if (state == AppLifecycleState.resumed) {
      _controller.start();
    }
  }

  /// Hàm bật/tắt camera
  Future<void> _toggleCamera() async {
    if (_cameraActive) {
      await _controller.stop();
      setState(() {
        _cameraActive = false;
      });
    } else {
      await _controller.start();
      setState(() {
        _cameraActive = true;
      });
    }
  }

  /// Hàm reset scanner để cho phép quét lại
  Future<void> _resetScanner() async {
    setState(() {
      barcodeValue = '';
      _hasScanned = false;
    });
    if (_cameraActive) {
      await TemporaryBusiness.resetScanner(_controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GeneralScreenScaffold(
      title: Text("TEMPORARY"),
      showBackButton: true,
      genAppBar: TemporaryComponentWidgets.buildTemporaryAppBar(
        torchEnabled: _torchEnabled,
        cameraActive: _cameraActive,
        onToggleCamera: _toggleCamera,
        onToggleTorch: () async {
          final newState = await TemporaryBusiness.toggleTorch(
            _controller,
            _torchEnabled,
          );
          setState(() {
            _torchEnabled = newState;
          });
        },
        onSwitchCamera: () async {
          await TemporaryBusiness.switchCamera(_controller);
          setState(() {});
        },
      ),
      
      body: Column(
        children: [
          TemporaryComponentWidgets.buildTemporaryScannerSection(
            cameraActive: _cameraActive,
            controller: _controller,
            onDetect: (BarcodeCapture barcodeCapture) {
              if (_hasScanned) return; // Chỉ xử lý lần quét đầu tiên
              final code = TemporaryBusiness.processBarcode(barcodeCapture);
              if (code.isNotEmpty) {
                setState(() {
                  barcodeValue = code;
                  _hasScanned = true;
                });
                _controller.stop();
                debugPrint('Barcode found: $code');
              }
            },
          ),
          TemporaryComponentWidgets.buildFeatureTableTemporary(
            context,
            barcodeValue,
          ),
          TemporaryComponentWidgets.buildTemporaryScanAgainButton(
            _resetScanner,
          ),
        ],
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}

import 'package:demo_flutter_ex1/views/pages/widgets/general_screen.dart';
import 'package:demo_flutter_ex1/views/pages/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final FocusNode _focusNode = FocusNode();
  List<String> scannedBarcodes = []; 
  bool _torchEnabled = false;
  bool _hasScanned = false; 
  bool _cameraActive = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _focusNode.requestFocus();

    TemporaryBusiness.initializeScannerListener((String scannedValue) {
    setState(() {
      scannedBarcodes.add(scannedValue); // Add scanned value to UI
    });
  });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _focusNode.dispose();
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

  Future<void> _resetScanner() async {
    await TemporaryBusiness.resetScanner(_controller);
  }

  Future<void> _handleScannerButton() async {
    await TemporaryBusiness.triggerScan(_controller, (String code) {
      if (code.isNotEmpty) {
        setState(() {
          scannedBarcodes.add(code);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (KeyEvent event) async {
        if (event is KeyDownEvent && TemporaryBusiness.isScannerButtonPressed(event)) {
          await _handleScannerButton();
        }
      },
      child: GeneralScreenScaffoldHeaderIcons(
        title: const Text("TEMPORARY"),
        showBackButton: true,
        genAppBar: TemporaryComponentWidgets.buildTemporaryAppBar(
          torchEnabled: _torchEnabled,
          cameraActive: _cameraActive,
          onToggleCamera: () async {
            setState(() {
              _cameraActive = !_cameraActive;
            });
          },
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
        sizedBox: const SizedBox(height: 20),
        body: Column(
          children: [
            TemporaryComponentWidgets.buildTemporaryScannerSection(
              cameraActive: _cameraActive,
              controller: _controller,
              onDetect: (BarcodeCapture scanCapture) {
                if (_hasScanned) return; 
                final code = TemporaryBusiness.processBarcode(scanCapture);
                if (code.isNotEmpty) {
                  setState(() {
                    scannedBarcodes.add(code);
                    _hasScanned = true;
                  });
                  _controller.stop();
                  debugPrint('Barcode found: $code');
                }
              },
            ),
            TemporaryComponentWidgets.buildFeatureTableTemporary(
              context,
              scannedBarcodes,
            ),
            TemporaryComponentWidgets.buildTemporaryScanAgainButton(
              _resetScanner,
            ),
          ],
        ),
        bottomNavigationBar: const NavbarWidget(),
      ),
    );
  }
}

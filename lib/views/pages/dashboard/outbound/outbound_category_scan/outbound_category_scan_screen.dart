// outbound_category_scan_screen.dart
import 'package:demo_flutter_ex1/utilities/constants/style_constants.dart';
import 'package:demo_flutter_ex1/views/pages/dashboard/share_scanner/share_scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class OutboundCategoryScanScreen extends StatefulWidget {
  // Add callback parameters to handle actions from parent
  final VoidCallback? onCameraToggle;
  final VoidCallback? onClearData;

  const OutboundCategoryScanScreen({
    super.key,
    this.onCameraToggle,
    this.onClearData,
  });

  @override
  State<OutboundCategoryScanScreen> createState() =>
      OutboundCategoryScanScreenState();
}

class OutboundCategoryScanScreenState extends State<OutboundCategoryScanScreen>
    with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController();
  List<List<String>> scannedData = [];
  bool _torchEnabled = false;

  bool _cameraActive = false; // Set to true to enable camera by default

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Start camera when screen initializes
    _controller.start();
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

  Future<void> _resetScanner() async {
    await _controller.stop();
    await _controller.start();
    setState(() {
      _cameraActive = true;
    });
  }

  void toggleCamera() {
    setState(() {
      _cameraActive = !_cameraActive;
      if (_cameraActive) {
        _controller.start();
      } else {
        _controller.stop();
      }
    });

    // Call parent callback if provided
    if (widget.onCameraToggle != null) {
      widget.onCameraToggle!();
    }
  }

  // Add method to clear scanned data
  void clearScannedData() {
    setState(() {
      scannedData.clear();
    });

    // Call parent callback if provided
    if (widget.onClearData != null) {
      widget.onClearData!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SharedScannerScreen(
      title: const Text(""), // Empty title since parent will show the title
      showAppBar: false, // Changed to false to avoid duplicate AppBar
      scannerController: _controller,
      cameraActive: _cameraActive,
      onDetect: (BarcodeCapture capture) {
        if (capture.barcodes.isNotEmpty) {
          final code = capture.barcodes.first.rawValue ?? "";
          if (code.isNotEmpty) {
            setState(() {
              scannedData.add([code, "Status", "Quantity", "Total"]);
            });
            _controller.stop();
            setState(() {
              _cameraActive = false;
            });
          }
        }
      },
      scannedData: scannedData,
      onScanAgain: _resetScanner,
      tableHeaderLabels: const ["Code", "Status", "Quantity", "Total"],
      // Apply new UI customizations from enhanced SharedScannerScreen
      scannerSectionHeight: 160,
      scannerSectionWidth: 320,
      scannerBorderRadius: 12,
      scannerBorderColor: Colors.black87,
      scannerBackgroundColor: Colors.black87,
      tableHeaderColor: Colors.blue.shade50,
      tableBorderColor: Colors.grey.shade300,
      headerTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: ColorsConstants.primaryColor,
      ),
      rowTextStyle: const TextStyle(fontSize: 13),
      tableHeaderPadding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 10,
      ),
      tableRowPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      noDataTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey.shade600,
        fontWeight: FontWeight.w500,
      ),
      scanAgainButtonStyle: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: ColorsConstants.primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onCameraOpen: toggleCamera,
      showBottomNavBar: false,
    );
  }
}

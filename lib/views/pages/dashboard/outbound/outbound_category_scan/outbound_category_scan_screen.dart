import 'package:demo_flutter_ex1/views/pages/dashboard/share_scanner/share_scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// Nếu có logic riêng, hoặc dùng chung

class OutboundCategoryScanScreen extends StatefulWidget {
  const OutboundCategoryScanScreen({super.key});

  @override
  State<OutboundCategoryScanScreen> createState() => _OutboundCategoryScanScreenState();
}

class _OutboundCategoryScanScreenState extends State<OutboundCategoryScanScreen>
    with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController();
  List<String> scannedData = [];
  bool _torchEnabled = false;
  bool _cameraActive = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Nếu có logic khởi tạo riêng cho outbound, bạn có thể gọi ở đây
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
    // Logic reset, có thể sử dụng logic tương tự như TemporaryBusiness
    await _controller.stop();
    await _controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return SharedScannerScreen(
      title: "OUTBOUND SCAN",
      showAppBar: false, // Giả sử màn hình con không có AppBar riêng
      scannerController: _controller,
      cameraActive: _cameraActive,
      onDetect: (BarcodeCapture capture) {
        if (capture.barcodes.isNotEmpty) {
          final code = capture.barcodes.first.rawValue ?? "";
          if (code.isNotEmpty) {
            setState(() {
              scannedData.add(code);
            });
            _controller.stop();
          }
        }
      },
      scannedData: scannedData,
      onScanAgain: _resetScanner,
      tableHeaderLabels: const ["Code Name", "Status", "Quantity", "Total"],
      // Nếu cần chỉnh sửa thêm style hoặc kích thước cho outbound, truyền thêm tham số tương ứng
      scannerSectionHeight: 160,
      scannerSectionWidth: 320,
    );
  }
}

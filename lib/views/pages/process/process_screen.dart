import 'package:demo_flutter_ex1/views/pages/process/widget_build_process_fn.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController();
  String barcodeValue = '';
  bool _torchEnabled = false;
  bool _hasScanned = false;
  bool _cameraActive = false; // Flag kiểm soát việc bật/tắt camera

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Không tự động start camera, chờ khi người dùng bật qua nút.
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_cameraActive) return; // Nếu camera đang tắt, không cần xử lý lifecycle
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      _controller.pause();
    } else if (state == AppLifecycleState.resumed) {
      _controller.start();
    }
  }

  /// Hàm reset scanner để quét lại
  void _resetScanner() {
    setState(() {
      barcodeValue = '';
      _hasScanned = false;
    });
    if (_cameraActive) {
      _controller.start();
    }
  }

  /// Hàm bật/tắt camera
  void _toggleCamera() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text("TEMPORARY")),
        actions: [
          IconButton(
            iconSize: 24,
            icon: Icon(
              _torchEnabled ? Icons.flash_on : Icons.flash_off,
              color: Colors.yellow,
            ),
            onPressed: () async {
              if (_cameraActive) {
                await _controller.toggleTorch();
                setState(() {
                  _torchEnabled = !_torchEnabled;
                });
              }
            },
          ),
          IconButton(
            iconSize: 24,
            icon: const Icon(Icons.flip_camera_ios),
            onPressed: () async {
              if (_cameraActive) {
                await _controller.switchCamera();
                setState(() {});
              }
            },
          ),
          // Nút bật/tắt camera
          IconButton(
            iconSize: 24,
            icon: Icon(
              _cameraActive ? Icons.stop : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: _toggleCamera,
          ),
        ],
      ),
      body: Column(
        children: [
          // Nếu camera đang bật, hiển thị MobileScanner; nếu tắt, hiển thị placeholder.
          SizedBox(
            height: 150,
            width: 300,
            child: _cameraActive
                ? MobileScanner(
                    controller: _controller,
                    onDetect: (BarcodeCapture capture) {
                      if (_hasScanned) return; // Chỉ xử lý lần quét đầu tiên
                      if (capture.barcodes.isNotEmpty) {
                        final barcode = capture.barcodes.first;
                        final code = barcode.rawValue;
                        if (code != null && code.isNotEmpty) {
                          setState(() {
                            barcodeValue = code;
                            _hasScanned = true;
                          });
                          // Dừng camera sau khi quét được
                          _controller.stop();
                          debugPrint('Barcode found: $code');
                        }
                      }
                    },
                  )
                : Container(
                    color: Colors.black,
                    child: const Center(
                      child: Text(
                        "Camera is off",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
          ),
          // Hiển thị kết quả quét qua widget con
          ProcessWidgets.buildFeatureTableTemporary(context, barcodeValue),
          ElevatedButton(
            onPressed: _resetScanner,
            child: const Text("Scan Again"),
          ),
        ],
      ),
    );
  }
}

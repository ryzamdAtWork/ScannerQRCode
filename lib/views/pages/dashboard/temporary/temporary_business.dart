import 'package:mobile_scanner/mobile_scanner.dart';

class TemporaryBusiness {
  
  /// Toggle đèn flash; trả về trạng thái mới (đảo ngược trạng thái hiện tại).
  static Future<bool> toggleTorch(
      MobileScannerController controller, bool currentTorch) async {
    await controller.toggleTorch();
    return !currentTorch;
  }

  /// Chuyển camera.
  static Future<void> switchCamera(MobileScannerController controller) async {
    await controller.switchCamera();
  }

  /// Reset scanner: dừng rồi khởi động lại.
  static Future<void> resetScanner(MobileScannerController controller) async {
    await controller.stop();
    await controller.start();
  }

  /// Xử lý kết quả quét: nếu có barcode, trả về giá trị đầu tiên; nếu không, trả về chuỗi rỗng.
  static String processBarcode(BarcodeCapture capture) {
    if (capture.barcodes.isNotEmpty) {
      final barcode = capture.barcodes.first;
      final code = barcode.rawValue;
      if (code != null && code.isNotEmpty) {
        return code;
      }
    }
    return '';
  }
}

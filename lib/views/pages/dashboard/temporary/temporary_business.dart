import 'package:mobile_scanner/mobile_scanner.dart';

class TemporaryBusiness {
  /// Xử lý kết quả quét. Nếu chưa quét (_hasScanned == false)
  /// và có barcode hợp lệ trong capture, trả về code; ngược lại, trả về chuỗi rỗng.
  static String processBarcode(BarcodeCapture capture, bool hasScanned) {
    if (hasScanned) return '';
    if (capture.barcodes.isNotEmpty) {
      final barcode = capture.barcodes.first;
      final code = barcode.rawValue;
      if (code != null && code.isNotEmpty) {
        return code;
      }
    }
    return '';
  }

  /// Toggle đèn flash. Nhận controller và trạng thái hiện tại,
  /// gọi hàm toggleTorch và trả về trạng thái mới (đảo ngược trạng thái hiện tại).
  static Future<bool> toggleTorch(
      MobileScannerController controller, bool currentTorchState) async {
    await controller.toggleTorch();
    // Giả sử toggle thành công, trạng thái mới sẽ là đối lập
    return !currentTorchState;
  }

  /// Chuyển camera qua lại.
  static Future<void> switchCamera(MobileScannerController controller) async {
    await controller.switchCamera();
  }

  /// Reset scanner: dừng camera rồi khởi động lại.
  static Future<void> resetScanner(MobileScannerController controller) async {
    await controller.stop();
    await controller.start();
  }
}

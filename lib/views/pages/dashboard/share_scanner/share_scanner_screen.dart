import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Widget chung cho màn hình quét barcode, có thể tái sử dụng cho nhiều screen.
class SharedScannerScreen extends StatefulWidget {
  final String title;
  final bool showAppBar;
  final MobileScannerController scannerController;
  final bool cameraActive;
  final Function(BarcodeCapture) onDetect;
  final List<String> scannedData;
  final VoidCallback onScanAgain;
  final List<String>? tableHeaderLabels;
  final TextStyle? headerTextStyle;
  final TextStyle? rowTextStyle;
  final Color? tableHeaderColor;
  final double? scannerSectionHeight;
  final double? scannerSectionWidth;

  const SharedScannerScreen({
    super.key,
    required this.title,
    this.showAppBar = true,
    required this.scannerController,
    required this.cameraActive,
    required this.onDetect,
    required this.scannedData,
    required this.onScanAgain,
    this.tableHeaderLabels,
    this.headerTextStyle,
    this.rowTextStyle,
    this.tableHeaderColor,
    this.scannerSectionHeight,
    this.scannerSectionWidth,
  });

  @override
  SharedScannerScreenState createState() => SharedScannerScreenState();
}

class SharedScannerScreenState extends State<SharedScannerScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!widget.cameraActive) return;
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      widget.scannerController.pause();
    } else if (state == AppLifecycleState.resumed) {
      widget.scannerController.start();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final headers = widget.tableHeaderLabels ?? ["Code Name", "Status", "Quantity", "Total"];
    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              title: Text(widget.title),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildScannerSection(),
            const SizedBox(height: 16),
            _buildTableHeader(headers),
            _buildTableData(widget.scannedData),
            const SizedBox(height: 16),
            _buildScanAgainButton(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildScannerSection() {
    return SizedBox(
      height: widget.scannerSectionHeight ?? 150,
      width: widget.scannerSectionWidth ?? 300,
      child: widget.cameraActive
          ? MobileScanner(
              controller: widget.scannerController,
              onDetect: widget.onDetect,
            )
          : Container(
              color: Colors.black,
              child: const Center(
                child: Text(
                  "Camera is off",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
    );
  }
  
  Widget _buildTableHeader(List<String> headers) {
    return Container(
      color: widget.tableHeaderColor ?? Colors.grey[350],
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        children: headers
            .map((header) => Expanded(
                  child: Text(
                    header,
                    textAlign: TextAlign.center,
                    style: widget.headerTextStyle ??
                        const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ))
            .toList(),
      ),
    );
  }
  
  Widget _buildTableData(List<String> data) {
    return SizedBox(
      height: 280,
      width: double.maxFinite,
      child: data.isEmpty
          ? const Center(child: Text("No scanned data"))
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return _buildTableRow(data[index]);
              },
            ),
    );
  }
  
  Widget _buildTableRow(String value) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: widget.rowTextStyle ??
                  const TextStyle(
                    color: Colors.black,
                  ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildScanAgainButton() {
    return ElevatedButton(
      onPressed: widget.onScanAgain,
      child: const Text("Scan Again"),
    );
  }
}

import 'package:flutter/material.dart';

class ProcessWidgets {
  static Widget buildFeatureTableTemporary(BuildContext context, String barcodeValue) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: Colors.black),
        borderRadius: BorderRadius.circular(1),
      ),
      child: Column(
        children: [
          Container(
            color: Colors.grey[350],
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Expanded(
                  child: Text(
                    "Code Name",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Status",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Quantity",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Total",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 280,
            width: double.maxFinite,
            color: Colors.white,
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                String category = "Dashboard";
                String status = "Active";
                String quantity = "10";
                String total = "120 PS";
                if (index == 1) {
                  category = barcodeValue;
                  status = "Online";
                  total = "450 PS";
                } else if (index == 2) {
                  category = barcodeValue;
                  status = "Pending";
                  total = "78 PS";
                }
                // Tạo hàng dữ liệu
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          category,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          status,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          quantity,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                       Expanded(
                        child: Text(
                          total,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

package com.example.demo_flutter_ex1

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

class BarcodeReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        val barcodeData = intent?.getStringExtra("barcode_value") // Change key if needed

        if (!barcodeData.isNullOrEmpty()) {
            Log.d("BarcodeReceiver", "Scanned Value: $barcodeData")

            // Use the methodChannel from MainActivity
            MainActivity.methodChannel?.invokeMethod("scannerKeyPressed", barcodeData)
        } else {
            Log.d("BarcodeReceiver", "No barcode data received.")
        }
    }
}

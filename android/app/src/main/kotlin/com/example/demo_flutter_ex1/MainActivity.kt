package com.example.demo_flutter_ex1

import android.content.IntentFilter
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.content.BroadcastReceiver
import android.content.Context
import android.view.KeyEvent

class MainActivity : FlutterActivity() {
    companion object {
        var methodChannel: MethodChannel? = null
    }

    private val CHANNEL = "com.example.demo_flutter_ex1/scanner"
    private val barcodeReceiver = BarcodeReceiver()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
    }

    override fun onResume() {
        super.onResume()
        val filter = IntentFilter("android.intent.action.BARCODE_SCANNER")
        registerReceiver(barcodeReceiver, filter)
    }

    override fun onPause() {
        super.onPause()
        unregisterReceiver(barcodeReceiver)
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        Log.d("MainActivity", "Key pressed: keyCode = $keyCode, event = $event")

        if (keyCode == 520) {
            Log.d("MainActivity", "Scanner button pressed, waiting for barcode...")
            return true
        }
        return super.onKeyDown(keyCode, event)
    }
}

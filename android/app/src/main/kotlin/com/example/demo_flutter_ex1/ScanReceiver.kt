package com.example.scanner;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class ScanReceiver extends BroadcastReceiver{
    @Override
    public void onReceive(Context context, Intent intent) {
        if ("com.ubx.datawedge.SCANNER_DECODE_EVENT".equals(intent.getAction()) ||
            "android.intent.ACTION_DECODE_DATA".equals(intent.getAction()) ||
            "urovo.rcv.message".equals(intent.getAction())) {

            String scanData = intent.getStringExtra("data"); // Hoặc thử các key khác như "barcode" hoặc "scan_data"
            if (scanData != null) {
                Log.d("ScanReceiver", "Data scanned: " + scanData);
            }
        }
    }
}

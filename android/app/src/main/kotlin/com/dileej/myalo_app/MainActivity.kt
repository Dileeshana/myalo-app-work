package com.dileej.myalo_app

import android.graphics.Bitmap
import android.content.res.AssetManager
import android.graphics.BitmapFactory
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine
import com.google.vr.sdk.widgets.pano.VrPanoramaView

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.myalodomain.vrchannel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "launchVR") {
                val contentPath: String? = call.argument("contentPath")
                launchVRMethod(contentPath ?: "images/panaroma.jpg")
                result.success("VR Launched")
            } else {
                result.notImplemented()
            }
        }
    }

    private fun launchVRMethod(contentPath: String) {
        val options = VrPanoramaView.Options()
        options.inputType = VrPanoramaView.Options.TYPE_MONO

        val vrPanoramaView: VrPanoramaView = findViewById(R.id.vrPanoramaView)

        val bitmap = getBitmapFromAsset(contentPath)
        if (bitmap != null) {
            vrPanoramaView.loadImageFromBitmap(bitmap, options)
        } else {
            // Handle error: Could not load the image
        }
    }

    private fun getBitmapFromAsset(assetPath: String): Bitmap? {
        return try {
            val assetManager: AssetManager = assets
            val inputStream = assetManager.open(assetPath)
            BitmapFactory.decodeStream(inputStream)
        } catch (e: Exception) {
            null
        }
    }
}

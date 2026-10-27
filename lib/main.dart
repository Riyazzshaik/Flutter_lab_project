import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Log and handle uncaught Flutter errors safely
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  // Graceful ErrorWidget so that if an unhandled rendering error occurs,
  // the app displays a recovery UI rather than a blank white screen.
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      color: const Color(0xFFF8F9FA),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline_rounded, size: 48, color: Color(0xFF1B4332)),
              const SizedBox(height: 12),
              const Text(
                'ReVive Encountered an Issue',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF16231C),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                details.exceptionAsString(),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: Color(0xFF55685F)),
              ),
            ],
          ),
        ),
      ),
    );
  };

  // Set system UI overlay style for seamless edge-to-edge feel
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const ReViveApp());
}

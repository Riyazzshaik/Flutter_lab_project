import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revive_marketplace/app.dart';
import 'package:revive_marketplace/screens/product_detail_screen.dart';

final Uint8List _transparentPng = Uint8List.fromList(<int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
  0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41,
  0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00,
  0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
  0x42, 0x60, 0x82,
]);

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _FakeHttpClient();
  }
}

class _FakeHttpClient implements HttpClient {
  @override
  bool autoUncompress = true;
  @override
  Duration? connectionTimeout;
  @override
  Duration idleTimeout = const Duration(seconds: 15);
  @override
  int? maxConnectionsPerHost;
  @override
  String? userAgent;

  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _FakeHttpClientRequest();

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeHttpClientRequest implements HttpClientRequest {
  @override
  final HttpHeaders headers = _FakeHttpHeaders();

  @override
  Future<HttpClientResponse> close() async => _FakeHttpClientResponse();

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeHttpHeaders implements HttpHeaders {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeHttpClientResponse extends Stream<List<int>> implements HttpClientResponse {
  @override
  int get statusCode => 200;
  @override
  int get contentLength => _transparentPng.length;
  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable([_transparentPng]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

void main() {
  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();
  });

  tearDownAll(() {
    HttpOverrides.global = null;
  });

  testWidgets('App renders Home screen with branding and navigation', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ReViveApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Verify ReVive title and brand tagline
    expect(find.text('ReVive'), findsOneWidget);
    expect(find.text('Give Good Things a Second Life'), findsOneWidget);

    // Verify search bar presence
    expect(find.byType(TextField), findsOneWidget);

    // Verify bottom navigation bar destinations
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('Sell'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('Bottom navigation switches between screens correctly', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ReViveApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Tap on Favorites tab
    await tester.tap(find.text('Favorites'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Saved Items'), findsOneWidget);

    // Tap on Sell tab
    await tester.tap(find.text('Sell'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('List a Second-Hand Item'), findsOneWidget);
    expect(find.text('Post Second-Hand Listing'), findsOneWidget);

    // Tap on Profile tab
    await tester.tap(find.text('Profile'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Eco Profile & Impact'), findsOneWidget);
    expect(find.text('Riyaz Shaik'), findsOneWidget);

    // Return to Home tab
    await tester.tap(find.text('Home'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('ReVive'), findsOneWidget);
  });

  testWidgets('Sell form validation prevents submission when empty', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ReViveApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Navigate to Sell screen
    await tester.tap(find.text('Sell'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Scroll submit button into view and tap it
    final submitButtonFinder = find.text('Post Second-Hand Listing');
    await tester.ensureVisible(submitButtonFinder);
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(submitButtonFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Validation errors should appear
    expect(find.text('Please enter a product title.'), findsOneWidget);
  });

  testWidgets('Hero transition navigates to ProductDetailScreen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ReViveApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Tap on a product card title in the feed
    final productFinder = find.text('OnePlus 11 5G (16GB RAM, 256GB)').first;
    await tester.ensureVisible(productFinder);
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(productFinder);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump(const Duration(milliseconds: 600));

    // Verify ProductDetailScreen is mounted
    expect(find.byType(ProductDetailScreen), findsOneWidget);
    expect(find.text('Contact Seller / Enquiry'), findsOneWidget);

    // Verify back navigation returns to Home
    final backButton = find.byTooltip('Back');
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.byType(ProductDetailScreen), findsNothing);
  });
}

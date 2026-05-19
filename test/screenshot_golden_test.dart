import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_ios_style_toggle/smooth_ios_style_toggle.dart';

/// Generates PNGs under [doc/screenshots] for the pub.dev README.
///
/// Regenerate after UI changes:
///   flutter test --update-goldens test/screenshot_golden_test.dart
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpToggle(
    WidgetTester tester, {
    required Widget child,
    Size surfaceSize = const Size(400, 120),
    Brightness brightness = Brightness.light,
  }) async {
    await tester.binding.setSurfaceSize(surfaceSize);
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          brightness: brightness,
          primarySwatch: Colors.teal,
          useMaterial3: true,
        ),
        home: Scaffold(
          backgroundColor:
              brightness == Brightness.dark ? Colors.black : Colors.white,
          body: Center(child: child),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('README screenshots', () {
    testWidgets('track labels — Online / Offline', (tester) async {
      await pumpToggle(
        tester,
        child: SmoothIOSToggle(
          value: true,
          activeText: 'Online',
          inactiveText: 'Offline',
          onChanged: (_) {},
          hapticFeedback: false,
          style: SmoothToggleStyle(
            trackWidth: 115,
            trackHeight: 40,
            trackPadding: 5,
            activeTrackColor: Colors.deepPurple,
            inactiveTrackColor: Colors.grey.shade700,
            activeThumbColor: Colors.white,
            inactiveThumbColor: Colors.black,
            activeTextColor: Colors.white,
            inactiveTextColor: Colors.white,
          ),
        ),
      );

      await expectLater(
        find.byType(SmoothIOSToggle),
        matchesGoldenFile('../doc/screenshots/toggle_track_labels_on.png'),
      );
    });

    testWidgets('default theme — off state', (tester) async {
      await pumpToggle(
        tester,
        child: SmoothIOSToggle(
          value: false,
          activeText: 'Yes',
          inactiveText: 'No',
          onChanged: (_) {},
          hapticFeedback: false,
          style: const SmoothToggleStyle(
            trackWidth: 110,
            trackHeight: 34,
          ),
        ),
      );

      await expectLater(
        find.byType(SmoothIOSToggle),
        matchesGoldenFile('../doc/screenshots/toggle_default_off.png'),
      );
    });

    testWidgets('text inside thumb', (tester) async {
      await pumpToggle(
        tester,
        child: SmoothIOSToggle(
          value: true,
          textInsideThumb: true,
          activeText: 'Dark',
          inactiveText: 'Lite',
          onChanged: (_) {},
          hapticFeedback: false,
          style: SmoothToggleStyle(
            trackWidth: 116,
            trackHeight: 36,
            activeTrackColor: Colors.deepPurple,
            inactiveTrackColor: Colors.grey.shade300,
            activeThumbColor: Colors.white,
            inactiveThumbColor: Colors.white,
            activeTextColor: Colors.deepPurple,
            inactiveTextColor: Colors.black87,
          ),
        ),
      );

      await expectLater(
        find.byType(SmoothIOSToggle),
        matchesGoldenFile('../doc/screenshots/toggle_text_inside_thumb.png'),
      );
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_ios_style_toggle/smooth_ios_style_toggle.dart';

void main() {
  group('SmoothIOSToggle - Golden Tests', () {
    testWidgets('Golden: default toggle (OFF state)', (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SmoothIOSToggle(
                value: false,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(SmoothIOSToggle),
        matchesGoldenFile('goldens/toggle_default_off.png'),
      );
    });

    testWidgets('Golden: default toggle (ON state)', (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SmoothIOSToggle(
                value: true,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(SmoothIOSToggle),
        matchesGoldenFile('goldens/toggle_default_on.png'),
      );
    });

    testWidgets('Golden: toggle with labels (OFF state)',
        (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SmoothIOSToggle(
                value: false,
                activeText: 'ON',
                inactiveText: 'OFF',
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(SmoothIOSToggle),
        matchesGoldenFile('goldens/toggle_labels_off.png'),
      );
    });

    testWidgets('Golden: toggle with labels (ON state)',
        (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SmoothIOSToggle(
                value: true,
                activeText: 'ON',
                inactiveText: 'OFF',
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(SmoothIOSToggle),
        matchesGoldenFile('goldens/toggle_labels_on.png'),
      );
    });

    testWidgets('Golden: toggle with text inside thumb (OFF state)',
        (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SmoothIOSToggle(
                value: false,
                activeText: 'ON',
                inactiveText: 'OFF',
                textInsideThumb: true,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(SmoothIOSToggle),
        matchesGoldenFile('goldens/toggle_text_inside_off.png'),
      );
    });

    testWidgets('Golden: toggle with text inside thumb (ON state)',
        (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SmoothIOSToggle(
                value: true,
                activeText: 'ON',
                inactiveText: 'OFF',
                textInsideThumb: true,
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(SmoothIOSToggle),
        matchesGoldenFile('goldens/toggle_text_inside_on.png'),
      );
    });

    testWidgets('Golden: custom styled toggle - deep purple (OFF state)',
        (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SmoothIOSToggle(
                value: false,
                activeText: 'ON',
                inactiveText: 'OFF',
                style: const SmoothToggleStyle(
                  trackWidth: 120,
                  trackHeight: 36,
                  thumbWidth: 48,
                  trackPadding: 4,
                  activeTrackColor: Colors.deepPurple,
                  inactiveTrackColor: Color(0xFF39393D),
                  activeThumbColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  activeTextColor: Colors.white,
                  inactiveTextColor: Colors.white70,
                ),
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(SmoothIOSToggle),
        matchesGoldenFile('goldens/toggle_purple_style_off.png'),
      );
    });

    testWidgets('Golden: custom styled toggle - deep purple (ON state)',
        (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SmoothIOSToggle(
                value: true,
                activeText: 'ON',
                inactiveText: 'OFF',
                style: const SmoothToggleStyle(
                  trackWidth: 120,
                  trackHeight: 36,
                  thumbWidth: 48,
                  trackPadding: 4,
                  activeTrackColor: Colors.deepPurple,
                  inactiveTrackColor: Color(0xFF39393D),
                  activeThumbColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  activeTextColor: Colors.white,
                  inactiveTextColor: Colors.white70,
                ),
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(SmoothIOSToggle),
        matchesGoldenFile('goldens/toggle_purple_style_on.png'),
      );
    });

    testWidgets('Golden: disabled toggle', (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SmoothIOSToggle(
                value: false,
                activeText: 'ON',
                inactiveText: 'OFF',
                enabled: false,
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(SmoothIOSToggle),
        matchesGoldenFile('goldens/toggle_disabled.png'),
      );
    });

    testWidgets('Golden: dark theme toggle (OFF state)',
        (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(
            body: Center(
              child: SmoothIOSToggle(
                value: false,
                activeText: 'ON',
                inactiveText: 'OFF',
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(SmoothIOSToggle),
        matchesGoldenFile('goldens/toggle_dark_theme_off.png'),
      );
    });

    testWidgets('Golden: dark theme toggle (ON state)',
        (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(
            body: Center(
              child: SmoothIOSToggle(
                value: true,
                activeText: 'ON',
                inactiveText: 'OFF',
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(SmoothIOSToggle),
        matchesGoldenFile('goldens/toggle_dark_theme_on.png'),
      );
    });
  });
}

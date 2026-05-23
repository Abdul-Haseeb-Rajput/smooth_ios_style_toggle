import 'dart:ui' show SemanticsFlag;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_ios_style_toggle/smooth_ios_style_toggle.dart';

void main() {
  testWidgets('toggles value on tap', (tester) async {
    var value = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SmoothIOSToggle(
            value: value,
            onChanged: (v) => value = v,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(SmoothIOSToggle));
    await tester.pumpAndSettle();

    expect(value, isTrue);
  });

  testWidgets('controller updates on tap', (tester) async {
    final controller = SmoothToggleController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SmoothIOSToggle(
            value: controller.value,
            controller: controller,
            onChanged: (v) => controller.value = v,
          ),
        ),
      ),
    );

    expect(controller.value, isFalse);

    await tester.tap(find.byType(SmoothIOSToggle));
    await tester.pumpAndSettle();

    expect(controller.value, isTrue);

    controller.dispose();
  });

  testWidgets('thumb width defaults to 1.7x thumb height', (tester) async {
    const style = SmoothToggleStyle(trackHeight: 30, trackPadding: 2);
    final thumbHeight = style.thumbHeightForTrack();
    final thumbWidth = style.thumbWidthForTrack();

    expect(thumbWidth, closeTo(thumbHeight * 1.7, 0.001));
  });

  test('custom thumbWidth is used when provided', () {
    const style = SmoothToggleStyle(trackWidth: 100, thumbWidth: 40);
    expect(style.thumbWidthForTrack(), 40);
  });

  test('trackHeight defaults to 30', () {
    const style = SmoothToggleStyle();
    expect(style.trackHeight, SmoothToggleStyle.defaultTrackHeight);
    expect(style.trackHeight, 30);
  });

  test('trackHeight rejects invalid values', () {
    expect(
      () => SmoothToggleStyle(trackHeight: 24),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => SmoothToggleStyle(trackHeight: 71),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => const SmoothToggleStyle(trackHeight: 25),
      returnsNormally,
    );
    expect(
      () => const SmoothToggleStyle(trackHeight: 70),
      returnsNormally,
    );
  });

  test('trackPadding rejects invalid values', () {
    expect(
      () => SmoothToggleStyle(trackHeight: 30, trackPadding: -1),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => SmoothToggleStyle(trackHeight: 25, trackPadding: 9),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => const SmoothToggleStyle(trackHeight: 30, trackPadding: 2),
      returnsNormally,
    );
    expect(
      () => const SmoothToggleStyle(trackHeight: 25, trackPadding: 8),
      returnsNormally,
    );
  });

  test('thumbWidth rejects invalid values', () {
    expect(
      () => SmoothToggleStyle(trackWidth: 100, thumbWidth: -1),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => SmoothToggleStyle(trackWidth: 100, thumbWidth: 10),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => SmoothToggleStyle(trackWidth: 100, thumbWidth: 60),
      throwsA(isA<AssertionError>()),
    );
  });

  test('text metrics scale with track dimensions', () {
    const compact = SmoothToggleStyle(trackHeight: 25, trackPadding: 2);
    const large = SmoothToggleStyle(trackHeight: 70, trackPadding: 4);

    expect(
        compact.fontSizeForThumbText(), lessThan(large.fontSizeForThumbText()));
    expect(
      compact.fontSizeForTrackLabel(),
      lessThan(large.fontSizeForTrackLabel()),
    );
    expect(compact.maxTrackLabelWidth(), greaterThan(0));
    expect(
      compact.thumbTextHorizontalInset(),
      lessThan(compact.thumbWidthForTrack()),
    );
  });

  test('resolveActiveTextStyle uses custom color and size', () {
    const style = SmoothToggleStyle(
      activeTextColor: Colors.red,
      activeTextStyle: TextStyle(fontSize: 16),
    );
    final theme = ThemeData.light();
    final resolved = style.resolveActiveTextStyle(
      theme,
      insideThumb: true,
    );
    expect(resolved.color, Colors.red);
    expect(resolved.fontSize, 16);
  });

  test('SmoothToggleController toggles', () {
    final controller = SmoothToggleController();
    expect(controller.value, isFalse);
    controller.toggle();
    expect(controller.value, isTrue);
    controller.dispose();
  });

  test('default thumb width is clamped to half of trackWidth', () {
    const style = SmoothToggleStyle(trackHeight: 30, trackWidth: 80);
    expect(style.thumbWidthForTrack(), 40); // 26 * 1.7 ≈ 44.2 → clamped to 80/2
    expect(style.thumbWidthForTrack(), lessThanOrEqualTo(style.trackWidth / 2));
    expect(
        style.thumbWidthForTrack(), greaterThanOrEqualTo(style.trackWidth / 4));
  });

  testWidgets('does not toggle when enabled is false', (tester) async {
    var value = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SmoothIOSToggle(
            value: value,
            enabled: false,
            onChanged: (v) => value = v,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(SmoothIOSToggle));
    await tester.pumpAndSettle();

    expect(value, isFalse);
  });

  testWidgets('internal controller toggles when onChanged is null',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SmoothIOSToggle(
            value: false,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(SmoothIOSToggle));
    await tester.pumpAndSettle();

    final semantics = tester.getSemantics(find.byType(SmoothIOSToggle));
    expect(semantics.hasFlag(SemanticsFlag.isToggled), isTrue);
  });

  testWidgets('syncs semantics when parent updates value', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              body: SmoothIOSToggle(
                value: true,
                onChanged: (_) {},
              ),
            );
          },
        ),
      ),
    );

    var semantics = tester.getSemantics(find.byType(SmoothIOSToggle));
    expect(semantics.hasFlag(SemanticsFlag.isToggled), isTrue);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SmoothIOSToggle(
            value: false,
            onChanged: (_) {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    semantics = tester.getSemantics(find.byType(SmoothIOSToggle));
    expect(semantics.hasFlag(SemanticsFlag.isToggled), isFalse);
  });

  testWidgets('space key toggles when focused', (tester) async {
    var value = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SmoothIOSToggle(
            value: value,
            autofocus: true,
            onChanged: (v) => value = v,
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pumpAndSettle();

    expect(value, isTrue);
  });

  testWidgets('drag past midpoint toggles value', (tester) async {
    var value = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SmoothIOSToggle(
              value: value,
              showText: false,
              onChanged: (v) => value = v,
            ),
          ),
        ),
      ),
    );

    await tester.timedDrag(
      find.byType(SmoothIOSToggle),
      const Offset(90, 0),
      const Duration(milliseconds: 200),
    );
    await tester.pumpAndSettle();

    expect(value, isTrue);
  });

  testWidgets('onToggle callback fires on tap', (tester) async {
    var toggleCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SmoothIOSToggle(
            value: false,
            onChanged: (_) {},
            onToggle: () => toggleCount++,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(SmoothIOSToggle));
    await tester.pumpAndSettle();

    expect(toggleCount, 1);
  });

  testWidgets('controller drives toggle when value prop is stale',
      (tester) async {
    final controller = SmoothToggleController(value: true);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SmoothIOSToggle(
            value: false,
            controller: controller,
            onChanged: (v) => controller.value = v,
          ),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.byType(SmoothIOSToggle));
    expect(semantics.hasFlag(SemanticsFlag.isToggled), isTrue);

    controller.dispose();
  });

  testWidgets('showText false hides label text', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SmoothIOSToggle(
            value: true,
            showText: false,
            onChanged: _noop,
          ),
        ),
      ),
    );

    expect(find.text('ON'), findsNothing);
    expect(find.text('OFF'), findsNothing);
  });

  testWidgets('uses SmoothToggleTheme when style is null', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SmoothToggleTheme(
            data: SmoothToggleStyle(trackHeight: 40),
            child: SmoothIOSToggle(
              value: false,
              onChanged: _noop,
            ),
          ),
        ),
      ),
    );

    final box = tester.renderObject<RenderBox>(find.byType(SmoothIOSToggle));
    expect(box.size.height, 40);
  });
}

void _noop(bool _) {}

import 'package:flutter/material.dart';
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

  testWidgets('thumb width is twice thumb height', (tester) async {
    const style = SmoothToggleStyle(trackHeight: 30, trackPadding: 2);
    final thumbHeight = style.thumbHeightForTrack();
    final thumbWidth = style.thumbWidthForTrack();

    expect(thumbWidth, thumbHeight * 2);
  });

  test('SmoothToggleController toggles', () {
    final controller = SmoothToggleController();
    expect(controller.value, isFalse);
    controller.toggle();
    expect(controller.value, isTrue);
    controller.dispose();
  });
}

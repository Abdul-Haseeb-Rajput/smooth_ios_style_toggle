import 'package:flutter/material.dart';

import 'smooth_toggle_style.dart';

/// App-wide defaults for [SmoothIOSToggle] using [InheritedWidget].
class SmoothToggleTheme extends InheritedWidget {
  const SmoothToggleTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final SmoothToggleStyle data;

  static SmoothToggleStyle? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SmoothToggleTheme>()
        ?.data;
  }

  static SmoothToggleStyle of(BuildContext context) {
    final style = maybeOf(context);
    assert(style != null, 'SmoothToggleTheme not found in context');
    return style!;
  }

  @override
  bool updateShouldNotify(SmoothToggleTheme oldWidget) =>
      data != oldWidget.data;
}

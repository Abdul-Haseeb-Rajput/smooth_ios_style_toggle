import 'package:flutter/foundation.dart';

/// Built-in state holder for [SmoothIOSToggle].
///
/// Extends [ValueNotifier] so you can use [ValueListenableBuilder] anywhere
/// in the tree without third-party state packages.
class SmoothToggleController extends ValueNotifier<bool> {
  /// Creates a controller with the given initial [value].
  SmoothToggleController({bool value = false}) : super(value);

  /// Current on/off state.
  @override
  bool get value => super.value;

  @override
  set value(bool newValue) {
    if (super.value == newValue) return;
    super.value = newValue;
  }

  /// Flips the current value.
  void toggle() => value = !value;
}

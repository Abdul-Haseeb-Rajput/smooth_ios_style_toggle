import 'package:flutter/material.dart';

/// Visual configuration for [SmoothIOSToggle].
@immutable
class SmoothToggleStyle {
  const SmoothToggleStyle({
    this.trackHeight = 31,
    this.trackWidth = 110,
    this.trackPadding = 2,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.activeTextStyle,
    this.inactiveTextStyle,
    this.activeTextColor,
    this.inactiveTextColor,
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 220),
    this.animationCurve = Curves.easeInOutCubic,
    this.thumbShadows,
    this.trackBorder,
    this.semanticLabel,
  });

  /// Height of the outer track.
  final double trackHeight;

  /// Width of the outer track.
  final double trackWidth;

  /// Padding between track edge and thumb.
  final double trackPadding;

  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final TextStyle? activeTextStyle;
  final TextStyle? inactiveTextStyle;
  final Color? activeTextColor;
  final Color? inactiveTextColor;
  final BorderRadius? borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;
  final List<BoxShadow>? thumbShadows;
  final BoxBorder? trackBorder;
  final String? semanticLabel;

  /// Thumb height equals inner track height; thumb width is always 2× height.
  double thumbHeightForTrack() =>
      (trackHeight - (trackPadding * 2)).clamp(0, double.infinity);

  double thumbWidthForTrack() => thumbHeightForTrack() * 2;

  SmoothToggleStyle copyWith({
    double? trackHeight,
    double? trackWidth,
    double? trackPadding,
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? activeThumbColor,
    Color? inactiveThumbColor,
    TextStyle? activeTextStyle,
    TextStyle? inactiveTextStyle,
    Color? activeTextColor,
    Color? inactiveTextColor,
    BorderRadius? borderRadius,
    Duration? animationDuration,
    Curve? animationCurve,
    List<BoxShadow>? thumbShadows,
    BoxBorder? trackBorder,
    String? semanticLabel,
  }) {
    return SmoothToggleStyle(
      trackHeight: trackHeight ?? this.trackHeight,
      trackWidth: trackWidth ?? this.trackWidth,
      trackPadding: trackPadding ?? this.trackPadding,
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      activeThumbColor: activeThumbColor ?? this.activeThumbColor,
      inactiveThumbColor: inactiveThumbColor ?? this.inactiveThumbColor,
      activeTextStyle: activeTextStyle ?? this.activeTextStyle,
      inactiveTextStyle: inactiveTextStyle ?? this.inactiveTextStyle,
      activeTextColor: activeTextColor ?? this.activeTextColor,
      inactiveTextColor: inactiveTextColor ?? this.inactiveTextColor,
      borderRadius: borderRadius ?? this.borderRadius,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      thumbShadows: thumbShadows ?? this.thumbShadows,
      trackBorder: trackBorder ?? this.trackBorder,
      semanticLabel: semanticLabel ?? this.semanticLabel,
    );
  }

  static SmoothToggleStyle lerp(
    SmoothToggleStyle a,
    SmoothToggleStyle b,
    double t,
  ) {
    return SmoothToggleStyle(
      trackHeight: _lerpDouble(a.trackHeight, b.trackHeight, t),
      trackWidth: _lerpDouble(a.trackWidth, b.trackWidth, t),
      trackPadding: _lerpDouble(a.trackPadding, b.trackPadding, t),
      activeTrackColor: Color.lerp(a.activeTrackColor, b.activeTrackColor, t),
      inactiveTrackColor:
          Color.lerp(a.inactiveTrackColor, b.inactiveTrackColor, t),
      activeThumbColor: Color.lerp(a.activeThumbColor, b.activeThumbColor, t),
      inactiveThumbColor:
          Color.lerp(a.inactiveThumbColor, b.inactiveThumbColor, t),
      animationDuration: t < 0.5 ? a.animationDuration : b.animationDuration,
      animationCurve: t < 0.5 ? a.animationCurve : b.animationCurve,
    );
  }

  static double _lerpDouble(double a, double b, double t) => a + (b - a) * t;
}

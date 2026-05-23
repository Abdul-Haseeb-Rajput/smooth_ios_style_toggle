import 'package:flutter/material.dart';

/// Visual configuration for [SmoothIOSToggle].
@immutable
class SmoothToggleStyle {
  /// Default outer track height.
  static const double defaultTrackHeight = 30;

  /// Minimum allowed [trackHeight].
  static const double minTrackHeight = 25;

  /// Maximum allowed [trackHeight].
  static const double maxTrackHeight = 70;

  /// Default inset between track edge and thumb.
  static const double defaultTrackPadding = 2;

  /// Minimum allowed [trackPadding].
  static const double minTrackPadding = 0;

  /// Minimum thumb height required when validating [trackPadding].
  static const double minThumbHeight = 8;

  const SmoothToggleStyle({
    this.trackHeight = defaultTrackHeight,
    this.trackWidth = 110,
    this.trackPadding = defaultTrackPadding,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.activeTextStyle,
    this.inactiveTextStyle,
    this.activeTextColor,
    this.inactiveTextColor,
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.thumbShadows,
    this.trackBorder,
    this.semanticLabel,
    this.thumbWidth,
  })  : assert(
          trackHeight >= minTrackHeight,
          'trackHeight cannot be less than $minTrackHeight',
        ),
        assert(
          trackHeight <= maxTrackHeight,
          'trackHeight cannot exceed $maxTrackHeight',
        ),
        assert(
          trackPadding >= minTrackPadding,
          'trackPadding cannot be negative',
        ),
        assert(
          2 * trackPadding <= trackHeight - minThumbHeight,
          'trackPadding is too large for trackHeight (thumb needs at least '
          '$minThumbHeight logical pixels of height)',
        ),
        assert(
          thumbWidth == null || thumbWidth >= 0,
          'thumbWidth cannot be negative',
        ),
        assert(
          thumbWidth == null || thumbWidth <= trackWidth / 2,
          'thumbWidth cannot exceed half of trackWidth',
        ),
        assert(
          thumbWidth == null || thumbWidth >= trackWidth / 4,
          'thumbWidth cannot be less than a quarter of trackWidth',
        );

  /// Height of the outer track ([minTrackHeight]–[maxTrackHeight], default [defaultTrackHeight]).
  final double trackHeight;

  /// Width of the outer track.
  final double trackWidth;

  /// Padding between track edge and thumb (≥ [minTrackPadding], leaves room for thumb).
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

  /// Optional thumb width. When null, defaults to ~1.7× [thumbHeightForTrack].
  ///
  /// Must be non-negative, at least [trackWidth] / 4, and at most [trackWidth] / 2.
  final double? thumbWidth;

  /// Thumb height equals inner track height.
  double thumbHeightForTrack() =>
      (trackHeight - (trackPadding * 2)).clamp(0, double.infinity);

  /// Resolved thumb width (custom [thumbWidth] or default ~1.7× height).
  ///
  /// Clamped to [trackWidth] / 4 … [trackWidth] / 2 so the thumb always fits the track.
  double thumbWidthForTrack() {
    final minW = trackWidth / 4;
    final maxW = trackWidth / 2;
    final raw = thumbWidth ?? thumbHeightForTrack() * 1.7;
    return raw.clamp(minW, maxW);
  }

  /// Horizontal gap between thumb edge and track labels.
  double trackLabelGap() => (trackPadding + 2).clamp(4.0, 8.0);

  /// Max width for a label in the track beside the thumb.
  double maxTrackLabelWidth() {
    final gap = trackLabelGap();
    return (trackWidth - (trackPadding * 2) - thumbWidthForTrack() - gap)
        .clamp(0, double.infinity);
  }

  /// Horizontal inset for text drawn inside the thumb.
  double thumbTextHorizontalInset() {
    final w = thumbWidthForTrack();
    return (w * 0.12).clamp(4.0, 14.0);
  }

  /// Suggested font size for text inside the thumb (overridable via [activeTextStyle]).
  double fontSizeForThumbText() {
    final h = thumbHeightForTrack();
    return (h * 0.46).clamp(9.0, 22.0);
  }

  /// Suggested font size for labels beside the thumb (overridable via text styles).
  double fontSizeForTrackLabel() {
    return (trackHeight * 0.36).clamp(9.0, 18.0);
  }

  /// Base [TextStyle] for toggle labels before theme / custom merges.
  TextStyle baseLabelTextStyle({required bool insideThumb}) {
    final fontSize =
        insideThumb ? fontSizeForThumbText() : fontSizeForTrackLabel();
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      letterSpacing: fontSize * 0.02,
      height: 1.0,
    );
  }

  /// Active label style sized for [insideThumb] vs track gap layout.
  TextStyle resolveActiveTextStyle(
    ThemeData theme, {
    required bool insideThumb,
    TextStyle? themeFallback,
  }) {
    final fallback =
        themeFallback ?? theme.textTheme.labelSmall ?? const TextStyle();
    final color = activeTextColor ?? Colors.white;
    return fallback
        .merge(baseLabelTextStyle(insideThumb: insideThumb))
        .merge(activeTextStyle ?? const TextStyle())
        .copyWith(color: activeTextStyle?.color ?? color);
  }

  /// Inactive label style sized for [insideThumb] vs track gap layout.
  TextStyle resolveInactiveTextStyle(
    ThemeData theme, {
    required bool insideThumb,
    TextStyle? themeFallback,
  }) {
    final fallback =
        themeFallback ?? theme.textTheme.labelSmall ?? const TextStyle();
    final defaultColor =
        theme.brightness == Brightness.dark ? Colors.white70 : Colors.black54;
    return fallback
        .merge(baseLabelTextStyle(insideThumb: insideThumb))
        .merge(inactiveTextStyle ?? const TextStyle())
        .copyWith(
          color: inactiveTextColor ?? inactiveTextStyle?.color ?? defaultColor,
        );
  }

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
    double? thumbWidth,
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
      thumbWidth: thumbWidth ?? this.thumbWidth,
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

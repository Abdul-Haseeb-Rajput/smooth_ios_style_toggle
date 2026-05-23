import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'smooth_toggle_controller.dart';
import 'smooth_toggle_style.dart';
import 'smooth_toggle_theme.dart';

/// A smooth, fully customizable iOS-style toggle with a pill thumb (~1.7× height)
/// and optional labels rendered beside the thumb inside the track.
class SmoothIOSToggle extends StatefulWidget {
  const SmoothIOSToggle({
    super.key,
    required this.value,
    this.onChanged,
    this.controller,
    this.activeText,
    this.inactiveText,
    this.style,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.onToggle,
    this.hapticFeedback = true,
    this.showText = true,
    this.textInsideThumb = false,
  });

  /// Whether the toggle is on.
  final bool value;

  /// Called when the user toggles. When null the widget is displayed as disabled.
  final ValueChanged<bool>? onChanged;

  /// Optional [ValueNotifier]-based controller for imperative updates.
  final SmoothToggleController? controller;

  /// Label shown beside the thumb when on (defaults to theme / "ON").
  final String? activeText;

  /// Label shown beside the thumb when off (defaults to theme / "OFF").
  final String? inactiveText;

  /// Per-widget styling. Falls back to [SmoothToggleTheme] then Material defaults.
  final SmoothToggleStyle? style;

  final bool enabled;
  final FocusNode? focusNode;
  final bool autofocus;
  final VoidCallback? onToggle;

  /// Light impact haptic on successful toggle (mobile platforms).
  final bool hapticFeedback;

  /// When false, no text is painted.
  final bool showText;

  /// When true, text is centered inside the pill thumb instead of the track gap.
  final bool textInsideThumb;

  @override
  State<SmoothIOSToggle> createState() => _SmoothIOSToggleState();
}

class _SmoothIOSToggleState extends State<SmoothIOSToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _positionAnimation;
  SmoothToggleController? _internalController;
  bool _isDragging = false;
  bool _didInitAnimation = false;
  bool _suppressTap = false;
  double _dragDistance = 0;

  bool get _canInteract =>
      widget.enabled &&
      (widget.onChanged != null ||
          widget.controller != null ||
          _internalController != null);

  bool get _currentValue =>
      widget.controller?.value ?? _internalController?.value ?? widget.value;

  @override
  void initState() {
    super.initState();
    _bindController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: _currentValue ? 1.0 : 0.0,
    );
    _positionAnimation = _animationController;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didInitAnimation) return;
    _didInitAnimation = true;
    final style = _resolvedStyle(context);
    _animationController.duration = style.animationDuration;
    _positionAnimation = CurvedAnimation(
      parent: _animationController,
      curve: style.animationCurve,
    );
  }

  void _bindController() {
    if (widget.controller != null) {
      widget.controller!.addListener(_onControllerChanged);
    } else if (widget.onChanged == null) {
      _internalController = SmoothToggleController(value: widget.value);
    }
  }

  @override
  void didUpdateWidget(SmoothIOSToggle oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onControllerChanged);
      if (widget.controller != null) {
        widget.controller!.addListener(_onControllerChanged);
      }
    }

    if (oldWidget.controller == null &&
        widget.controller == null &&
        widget.onChanged != null &&
        oldWidget.onChanged == null) {
      _internalController?.dispose();
      _internalController = null;
    }

    if (!_isDragging && _currentValue != _valueAt(oldWidget)) {
      _animateTo(_currentValue);
    }

    final style = _resolvedStyle(context);
    if (style.animationDuration != _animationController.duration) {
      _animationController.duration = style.animationDuration;
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onControllerChanged);
    _internalController?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  bool _valueAt(SmoothIOSToggle w) => w.controller?.value ?? w.value;

  void _onControllerChanged() {
    if (!_isDragging) {
      _animateTo(widget.controller!.value);
    }
    setState(() {});
  }

  bool get _parentOwnsState =>
      widget.onChanged != null &&
      widget.controller == null &&
      _internalController == null;

  SmoothToggleStyle _resolvedStyle(BuildContext context) {
    final theme = Theme.of(context);
    final inherited = SmoothToggleTheme.maybeOf(context);
    final base = widget.style ?? inherited ?? const SmoothToggleStyle();

    final activeTrack = base.activeTrackColor ?? theme.colorScheme.primary;
    final inactiveTrack = base.inactiveTrackColor ??
        (theme.brightness == Brightness.dark
            ? const Color(0xFF39393D)
            : const Color(0xFFE9E9EA));
    final thumbColor = base.activeThumbColor ??
        base.inactiveThumbColor ??
        (theme.brightness == Brightness.dark
            ? const Color(0xFFFAFAFA)
            : Colors.white);

    return base.copyWith(
      activeTrackColor: activeTrack,
      inactiveTrackColor: inactiveTrack,
      activeThumbColor: base.activeThumbColor ?? thumbColor,
      inactiveThumbColor: base.inactiveThumbColor ?? thumbColor,
      borderRadius:
          base.borderRadius ?? BorderRadius.circular(base.trackHeight / 2),
    );
  }

  Future<void> _animateTo(bool on) {
    if (on) {
      return _animationController.forward();
    }
    return _animationController.reverse();
  }

  void _setValue(bool value) {
    _internalController?.value = value;
    if (widget.controller != null) {
      widget.controller!.value = value;
    }
    widget.onChanged?.call(value);
    widget.onToggle?.call();
  }

  void _syncAnimationToCurrentValue() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_isDragging) {
        _animateTo(_currentValue);
      }
    });
  }

  void _handleTap() {
    if (!_canInteract) return;
    final next = !_currentValue;
    if (next == _currentValue) return;
    _setValue(next);
    if (_parentOwnsState) {
      _syncAnimationToCurrentValue();
    } else {
      _animateTo(next);
    }
    if (widget.hapticFeedback) {
      _triggerHaptic();
    }
  }

  void _commitDragEnd() {
    setState(() => _isDragging = false);
    final targetOn = _animationController.value >= 0.5;
    if (targetOn != _currentValue) {
      _setValue(targetOn);
    }
    if (_parentOwnsState) {
      _syncAnimationToCurrentValue();
    } else {
      _animateTo(_currentValue);
    }
    if (widget.hapticFeedback) {
      _triggerHaptic();
    }
  }

  void _triggerHaptic() {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android) {
      HapticFeedback.heavyImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _resolvedStyle(context);
    final activeLabel = widget.activeText ?? 'ON';
    final inactiveLabel = widget.inactiveText ?? 'OFF';

    return Semantics(
      toggled: _currentValue,
      enabled: _canInteract,
      label: style.semanticLabel,
      child: Focus(
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        onKeyEvent: (node, event) {
          if (!_canInteract) {
            return KeyEventResult.ignored;
          }
          if (event is! KeyDownEvent) {
            return KeyEventResult.ignored;
          }
          if (event.logicalKey == LogicalKeyboardKey.enter ||
              event.logicalKey == LogicalKeyboardKey.space) {
            _handleTap();
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (_suppressTap) {
              _suppressTap = false;
              return;
            }
            _handleTap();
          },
          onHorizontalDragStart: _canInteract
              ? (_) {
                  _dragDistance = 0;
                  setState(() => _isDragging = true);
                }
              : null,
          onHorizontalDragUpdate: _canInteract
              ? (details) {
                  _dragDistance += details.delta.dx.abs();
                  final box = context.findRenderObject() as RenderBox?;
                  if (box == null) return;
                  final width = box.size.width;
                  final thumbWidth = style.thumbWidthForTrack();
                  final travel = width - (style.trackPadding * 2) - thumbWidth;
                  if (travel <= 0) return;
                  final localDx = box.globalToLocal(details.globalPosition).dx;
                  final normalized =
                      ((localDx - style.trackPadding - thumbWidth / 2) / travel)
                          .clamp(0.0, 1.0);
                  _animationController.value = normalized;
                }
              : null,
          onHorizontalDragEnd: _canInteract
              ? (_) {
                  _suppressTap = _dragDistance > 4;
                  _commitDragEnd();
                }
              : null,
          onHorizontalDragCancel: _canInteract
              ? () {
                  setState(() => _isDragging = false);
                  _animateTo(_currentValue);
                }
              : null,
          child: AnimatedBuilder(
            animation: _positionAnimation,
            builder: (context, child) {
              return _SmoothToggleRender(
                progress: _positionAnimation.value,
                style: style,
                activeText: activeLabel,
                inactiveText: inactiveLabel,
                showText: widget.showText,
                textInsideThumb: widget.textInsideThumb,
                enabled: _canInteract,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SmoothToggleRender extends StatelessWidget {
  const _SmoothToggleRender({
    required this.progress,
    required this.style,
    required this.activeText,
    required this.inactiveText,
    required this.showText,
    required this.textInsideThumb,
    required this.enabled,
  });

  final double progress;
  final SmoothToggleStyle style;
  final String activeText;
  final String inactiveText;
  final bool showText;
  final bool textInsideThumb;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trackColor =
        Color.lerp(style.inactiveTrackColor, style.activeTrackColor, progress)!;

    final thumbHeight = style.thumbHeightForTrack();
    final thumbWidth = style.thumbWidthForTrack();
    final thumbRadius = Radius.circular(thumbHeight / 2);

    final trackWidth = style.trackWidth;
    final trackHeight = style.trackHeight;
    final padding = style.trackPadding;

    final travel = trackWidth - (padding * 2) - thumbWidth;
    final thumbLeft = padding + (travel * progress);

    final opacity = enabled ? 1.0 : 0.45;
    final labelGap = style.trackLabelGap();
    final trackLabelMaxWidth = style.maxTrackLabelWidth();
    final thumbInset = style.thumbTextHorizontalInset();
    final thumbLabelMaxWidth =
        (thumbWidth - (thumbInset * 2)).clamp(0.0, thumbWidth).toDouble();

    final activeTextStyle = style.resolveActiveTextStyle(
      theme,
      insideThumb: textInsideThumb,
    );
    final inactiveTextStyle = style.resolveInactiveTextStyle(
      theme,
      insideThumb: textInsideThumb,
    );

    final displayActive = showText && progress > 0.35;
    final displayInactive = showText && progress < 0.65;

    return Opacity(
      opacity: opacity,
      child: SizedBox(
        width: trackWidth,
        height: trackHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Track
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: trackColor,
                  borderRadius: style.borderRadius,
                  border: style.trackBorder,
                ),
              ),
            ),
            // Track labels (beside thumb)
            if (showText && !textInsideThumb) ...[
              Positioned(
                left: padding + thumbWidth + labelGap,
                right: padding,
                top: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Opacity(
                    opacity: (1 - progress).clamp(0.0, 1.0),
                    child: _ScaledToggleLabel(
                      text: inactiveText,
                      style: inactiveTextStyle,
                      maxWidth: trackLabelMaxWidth,
                      maxHeight: trackHeight,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: padding,
                right: padding + thumbWidth + labelGap,
                top: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Opacity(
                    opacity: progress.clamp(0.0, 1.0),
                    child: _ScaledToggleLabel(
                      text: activeText,
                      style: activeTextStyle,
                      maxWidth: trackLabelMaxWidth,
                      maxHeight: trackHeight,
                    ),
                  ),
                ),
              ),
            ],
            // Pill thumb (width = 2 × height, fully rounded ends)
            Positioned(
              left: thumbLeft,
              top: padding,
              width: thumbWidth,
              height: thumbHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color.lerp(
                    style.inactiveThumbColor,
                    style.activeThumbColor,
                    progress,
                  ),
                  borderRadius: BorderRadius.all(thumbRadius),
                  boxShadow: style.thumbShadows ??
                      [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.18),
                          blurRadius: 4,
                          offset: const Offset(0, 1.5),
                        ),
                      ],
                ),
                child: showText && textInsideThumb
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: thumbInset),
                        child: Center(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 120),
                            opacity: displayActive || displayInactive ? 1 : 0,
                            child: _ScaledToggleLabel(
                              text: progress >= 0.5 ? activeText : inactiveText,
                              style: progress >= 0.5
                                  ? activeTextStyle
                                  : inactiveTextStyle,
                              maxWidth: thumbLabelMaxWidth,
                              maxHeight: thumbHeight,
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Single-line label that scales down to fit [maxWidth] × [maxHeight].
class _ScaledToggleLabel extends StatelessWidget {
  const _ScaledToggleLabel({
    required this.text,
    required this.style,
    required this.maxWidth,
    required this.maxHeight,
  });

  final String text;
  final TextStyle style;
  final double maxWidth;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    if (maxWidth <= 0 || maxHeight <= 0) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      width: maxWidth,
      height: maxHeight,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Text(
          text,
          maxLines: 1,
          softWrap: false,
          style: style,
        ),
      ),
    );
  }
}

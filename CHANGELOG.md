## 0.2.0

### Added

* Optional **`thumbWidth`** on `SmoothToggleStyle` (validated between `trackWidth / 4` and `trackWidth / 2`).
* **Validated dimensions** (debug asserts): `trackHeight` 25–70, `trackPadding` must leave ≥ 8 px for the thumb, `thumbWidth` bounds when set.
* **Adaptive label sizing**: font sizes scale with track/thumb size; labels use `FittedBox` so long text (e.g. `Online` / `Offline`) fits beside or inside the thumb.
* Style helpers: `fontSizeForThumbText()`, `fontSizeForTrackLabel()`, `maxTrackLabelWidth()`, `resolveActiveTextStyle()`, `resolveInactiveTextStyle()`, and related layout helpers.
* **`semanticLabel`** on `SmoothToggleStyle` for screen-reader names (wired to `Semantics.label`).
* Expanded **widget & unit tests** (21 tests): drag, keyboard, disabled state, theme, thumb clamping, and style validation.

### Changed

* Default **`trackHeight`** is **30** (was 31).
* Default thumb width is **~1.7× thumb height**, clamped so it never exceeds half of `trackWidth`.
* Default animation: **200 ms** with **`Curves.easeInOut`** (was 220 ms / `easeInOutCubic`).
* Parent-owned state (`value` + `onChanged` / `setState` / GetX): animation syncs after rebuild instead of racing ahead of the parent.
* Drag end no longer fires a duplicate tap; drag cancel snaps the thumb back to the current value.

### Fixed

* Toggle could **double-flip** when releasing after a drag (tap fired after drag end).
* **Animation / value desync** when the parent updated state asynchronously.
* **Oversized default thumb** on narrow `trackWidth` values (thumb now clamped to fit the track).

## 0.1.1

* Default `trackWidth` is **110** (was 74 in early drafts).

## 0.1.0

* Initial release of `SmoothIOSToggle` with pill thumb, inline labels, `SmoothToggleController`, and `SmoothToggleTheme`.
* Tap, drag, keyboard, semantics, and haptic feedback support.
* Works on Android, iOS, Web, Windows, macOS, and Linux.

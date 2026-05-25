# Golden Tests for smooth_ios_style_toggle

This directory contains **golden (visual regression) test files** for the `SmoothIOSToggle` widget.

## What are Golden Tests?

Golden tests capture the rendered output of widgets as image files (called "goldens"). When the test runs again, Flutter compares the current render against the saved golden image. If they differ, the test fails and you can review the differences.

This is useful for:
- **Regression detection** — Catch unintended visual changes
- **Style validation** — Ensure theme changes render correctly
- **Cross-platform verification** — Store once, verify on all platforms
- **Documentation** — Visual examples of all widget states

## Files

Each golden file corresponds to a test case in `../smooth_toggle_golden_test.dart`:

- `toggle_default_off.png` — Default style, OFF state
- `toggle_default_on.png` — Default style, ON state
- `toggle_labels_off.png` — With labels beside thumb, OFF state
- `toggle_labels_on.png` — With labels beside thumb, ON state
- `toggle_text_inside_off.png` — With text inside thumb, OFF state
- `toggle_text_inside_on.png` — With text inside thumb, ON state
- `toggle_purple_style_off.png` — Custom purple styling, OFF state
- `toggle_purple_style_on.png` — Custom purple styling, ON state
- `toggle_disabled.png` — Disabled state
- `toggle_dark_theme_off.png` — Dark theme, OFF state
- `toggle_dark_theme_on.png` — Dark theme, ON state

## Running Golden Tests

### Generate (or update) golden files

Use this when you intentionally change the widget's appearance and want to update the golden baseline:

```bash
flutter test --update-goldens
```

### Verify against existing goldens

Use this in CI to check if recent changes match the baseline:

```bash
flutter test
```

If a golden test fails, you'll see an error with a diff image showing the changes. Review the diff to ensure the changes are intentional.

## Workflow

1. **Create test** in `smooth_toggle_golden_test.dart` with `expectLater(..., matchesGoldenFile(...))`
2. **Generate baseline** with `flutter test --update-goldens`
3. **Commit** the `.png` files to Git
4. **Future runs** automatically compare against the committed baseline
5. **If visual change is intentional**, update the baseline again and commit

## Tips

- Keep test cases focused (one scenario per test)
- Use `addTearDown(tester.binding.window.clearPhysicalSizeTestValue)` to clean up size changes
- Name golden files descriptively (state, style, theme)
- Review diffs carefully before updating baseline — accidental visual regressions are easy to miss!

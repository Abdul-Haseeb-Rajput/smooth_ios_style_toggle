# Contributing

Thanks for helping improve **smooth_ios_style_toggle**!

## Workflow

1. **Fork** the repo and create a branch from `main` (e.g. `fix/thumb-clamp`).
2. Make your changes and run locally:
   ```bash
   dart analyze lib test
   flutter test
   ```
3. If you changed the widget's appearance, update golden test baselines:
   ```bash
   flutter test --update-goldens
   ```
4. Commit the updated golden files in `test/goldens/`.
5. Open a **pull request** into `main`.
6. Wait for **CI** (`analyze-and-test`) to pass (tests + coverage + golden verification).
7. A **code owner** ([@Abdul-Haseeb-Rajput](https://github.com/Abdul-Haseeb-Rajput)) must **approve** before the PR can merge.

Direct pushes to `main` are blocked by [repository rules](.github/RULES.md).

## Branch rules (summary)

| Rule | Detail |
| ---- | ------ |
| Pull request required | All changes land via PR |
| Owner approval | [CODEOWNERS](.github/CODEOWNERS) review required |
| CI must pass | `analyze-and-test` job on GitHub Actions |
| No force-push | History on `main` cannot be rewritten |
| No delete `main` | Default branch cannot be removed |

Repository administrators can bypass rules for emergencies only.

## Testing

Tests are **required** for all behavior changes. Use the following commands:

```bash
# Run all tests (unit, widget, and golden)
flutter test

# Update golden test baselines (visual regression)
# Use only after intentional appearance changes
flutter test --update-goldens

# Run with coverage report
flutter test --coverage
```

**Test coverage guidelines:**
- Target **80%+ coverage** on all new code
- Write **unit tests** for pure functions (validators, calculators)
- Write **widget tests** for state changes, gestures, theme resolution
- Add **golden tests** when visual changes affect widget appearance

See [test/goldens/README.md](test/goldens/README.md) for golden test details.

## Scope

- Keep PRs focused; avoid unrelated refactors.
- Match existing style in `lib/src/`.
- Add or update tests for behavior changes.

## Questions

Open a [GitHub issue](https://github.com/Abdul-Haseeb-Rajput/smooth_ios_style_toggle/issues) before large changes.

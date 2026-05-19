# Publish to pub.dev

## 1. Create a pub.dev account

1. Go to [https://pub.dev](https://pub.dev)
2. Sign in with your Google account
3. (Optional) Verify a [publisher](https://pub.dev/publishers) so your name appears on the package

## 2. Log in from the terminal

From the **package root** (folder with `pubspec.yaml`):

```bash
dart pub login
```

Complete the browser authorization when prompted.

## 3. Pre-publish checks

```bash
flutter pub get
dart analyze
flutter test
dart pub publish --dry-run
```

Fix any errors or warnings before continuing.

## 4. Publish

```bash
dart pub publish
```

When asked to confirm, type `y`.

Your package will appear at:

`https://pub.dev/packages/smooth_ios_style_toggle`

## 5. Use the published package

In an app `pubspec.yaml`:

```yaml
dependencies:
  smooth_ios_style_toggle: ^0.1.1
```

Then:

```bash
flutter pub get
```

## Common issues

| Issue | What to do |
| --- | --- |
| Package name already taken | Change `name:` in `pubspec.yaml` to something unique |
| `repository` URL invalid | Ensure the URL in `pubspec.yaml` exists and is reachable |
| Upload too large | Check `.pubignore` excludes `build/`, `example/build/` |
| Login failed | Run `dart pub logout` then `dart pub login` again |

## New versions later

1. Bump `version:` in `pubspec.yaml` (e.g. `0.1.2`)
2. Add notes under `CHANGELOG.md`
3. Run `dart analyze`, `flutter test`, `dart pub publish --dry-run`
4. Run `dart pub publish`

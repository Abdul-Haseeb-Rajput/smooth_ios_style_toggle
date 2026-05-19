# Publish to pub.dev (GitHub only — no website needed)

On pub.dev, **`homepage` can be your GitHub repository URL**. You do not need a separate website.

## Step 1 — Push to GitHub

1. Create a new repository on GitHub, e.g. `smooth_ios_style_toggle`.
2. From the package root:

```bash
git init
git add .
git commit -m "Initial release v0.1.0"
git branch -M main
git remote add origin https://github.com/Abdul-Haseeb-Rajput/smooth_ios_style_toggle.git
git push -u origin main
```

Replace `Abdul-Haseeb-Rajput` with your real GitHub username.

## Step 2 — Set URLs in `pubspec.yaml`

Edit these three lines (use your real username):

```yaml
homepage: https://github.com/Abdul-Haseeb-Rajput/smooth_ios_style_toggle
repository: https://github.com/Abdul-Haseeb-Rajput/smooth_ios_style_toggle
issue_tracker: https://github.com/Abdul-Haseeb-Rajput/smooth_ios_style_toggle/issues
```

Also replace `Abdul-Haseeb-Rajput` in `README.md` (Contributing + clone links).

## Step 3 — Screenshots on pub.dev

Screenshots are already in `doc/screenshots/` and referenced from `README.md`.
pub.dev renders images bundled in the package.

To refresh after UI changes:

```bash
flutter test --update-goldens test/screenshot_golden_test.dart
git add doc/screenshots/
git commit -m "Update README screenshots"
```

Optional: capture from the running example app (higher fidelity on device):

```bash
cd example
flutter run
# Take screenshots, save as doc/screenshots/*.png, commit
```

## Step 4 — pub.dev account

1. Open [https://pub.dev](https://pub.dev) and sign in with Google.
2. In a terminal:

```bash
dart pub login
```

Follow the browser prompt to authorize.

3. (Recommended) Verify a **publisher** at [pub.dev publishers](https://pub.dev/publishers) so your name appears on the package.

## Step 5 — Pre-publish checks

```bash
cd smooth_ios_style_toggle   # package root
flutter pub get
dart analyze
flutter test
dart pub publish --dry-run
```

Fix anything reported before the real publish.

## Step 6 — Publish

```bash
dart pub publish
```

Type `y` when prompted. The first publish of a new package name must be unique on pub.dev.

## Step 7 — After publish

```bash
git tag v0.1.0
git push origin v0.1.0
```

Visit `https://pub.dev/packages/smooth_ios_style_toggle` (after the name is live).

## Common issues

| Issue | Fix |
| --- | --- |
| `homepage` / `repository` 404 | Push the GitHub repo first, then publish |
| Name already taken | Pick a unique name in `pubspec.yaml` `name:` |
| Missing LICENSE | Already included (MIT) |
| Low pub points | Ensure `repository`, description, README, and passing `dart analyze` |
| Large upload | `.pubignore` excludes `example/build/` |

## Version bumps

1. Update `version:` in `pubspec.yaml` (semver).
2. Add a section to `CHANGELOG.md`.
3. Run tests and `dart pub publish`.

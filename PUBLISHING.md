# Publishing checklist (GitHub → pub.dev)

Use this before **git push** and **`dart pub publish`**.

## 1. Screenshots

1. Add four PNGs to [`doc/screenshots/`](doc/screenshots/README.md) (example app scrolled — 2× OFF, 2× ON):

   - `toggle_demo_off_1.png`
   - `toggle_demo_off_2.png`
   - `toggle_demo_on_1.png`
   - `toggle_demo_on_2.png`

2. Open `README.md` on GitHub and confirm all four images render.

## 2. Quality checks (repo root)

```bash
dart analyze lib test
flutter test
dart pub publish --dry-run
```

- **Analyzer:** no issues  
- **Tests:** 21 passing  
- **Dry-run:** no errors (a warning about uncommitted files is OK until you commit)

## 3. Version

- [`pubspec.yaml`](pubspec.yaml) → `version: 0.2.0`
- [`CHANGELOG.md`](CHANGELOG.md) → `## 0.2.0` section filled in

## 4. Push to GitHub

**`main` is protected** (PR + owner approval + CI). See [`.github/RULES.md`](.github/RULES.md). To land a release, merge a PR or use an admin bypass after importing [`.github/rulesets/main.json`](.github/rulesets/main.json).

```bash
git status
git add .
git commit -m "Release v0.2.0: adaptive text, validated sizing, bug fixes"
git push origin main
```

**PR fallback:** `git push -u origin HEAD:release/v0.2.0` → merge on GitHub.

## 5. Publish to pub.dev

1. Log in once: `dart pub login`
2. Publish from a **clean** commit (same as GitHub):

   ```bash
   dart pub publish
   ```

3. Type `y` to confirm when prompted.
4. Verify: https://pub.dev/packages/smooth_ios_style_toggle

## 6. After publish

- Tag the release on GitHub: `v0.2.0`
- Optionally create a GitHub Release notes from `CHANGELOG.md`

## Files intentionally not published

See [`.pubignore`](.pubignore): `.git/`, `build/`, `.fvm/`, `example/android/local.properties`, etc.

## Common issues

| Issue | Fix |
| ----- | --- |
| Modified files warning on publish | Commit all changes first |
| README images broken on pub.dev | Use `doc/screenshots/` paths; commit image files |
| `elevation` build error in example | Use FVM — see [TOOLING.md](TOOLING.md) |

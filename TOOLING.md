# Flutter SDK setup (fix build errors)

## `elevation` error in `semantics.dart`

If you see:

```text
Error: No named parameter with the name 'elevation'.
  elevation: data.elevation,
```

in `C:/flutter/packages/flutter/lib/src/semantics/semantics.dart`, your build is using **two different Flutter SDKs** (for example FVM `3.38.2` + global `C:\flutter` `3.29.3`). The framework and engine must come from the **same** installation.

## Fix (recommended): use FVM for this project

From the repository root:

```bash
fvm install
fvm use
cd example
fvm flutter clean
fvm flutter pub get
fvm flutter run
```

Always prefer `fvm flutter` instead of a global `flutter` command in this repo.

## Fix `example/android/local.properties`

`flutter.sdk` must point to this project's FVM SDK:

```properties
flutter.sdk=C:\\path\\to\\smooth_ios_style_toggle\\.fvm\\flutter_sdk
```

See `example/android/local.properties.example`.

## Fix global SDK mismatch (optional)

If you use `C:\flutter` globally:

```bash
cd C:\flutter
flutter upgrade
flutter doctor
```

Or remove a conflicting `FLUTTER_ROOT` environment variable (Windows: System Properties → Environment Variables).

## VS Code / Android Studio

- **VS Code**: uses `.vscode/settings.json` → `"dart.flutterSdkPath": ".fvm/versions/3.29.3"`
- **Android Studio**: Settings → Languages & Frameworks → Flutter → SDK path → `.fvm/flutter_sdk` inside this project

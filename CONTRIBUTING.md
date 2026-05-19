# Contributing

Thank you for contributing to [smooth_ios_style_toggle](https://github.com/Abdul-Haseeb-Rajput/smooth_ios_style_toggle).

## Before you start

- Search [existing issues](https://github.com/Abdul-Haseeb-Rajput/smooth_ios_style_toggle/issues) to avoid duplicates.
- For **security** issues, do **not** open a public issue. See [SECURITY.md](SECURITY.md).

## How to contribute

1. **Fork** the repository and create a branch from `main`.
2. Make your changes in a focused PR (one feature or fix per PR).
3. Run checks locally:

   ```bash
   flutter pub get
   dart analyze
   flutter test
   cd example && flutter pub get && dart analyze
   ```

4. Update `CHANGELOG.md` for user-visible changes.
5. Open a **Pull Request** against `main` and fill out the PR template.

## Code guidelines

- Match existing style and naming in `lib/src/`.
- Avoid new dependencies unless discussed in an issue first.
- Keep the package free of third-party state-management libraries.
- Add or update tests when behavior changes.

## Pull request review

- Run `dart analyze` and `flutter test` locally before opening a PR.
- Maintainers review all PRs; direct pushes to `main` should be restricted on GitHub (see [GITHUB_BRANCH_PROTECTION.md](GITHUB_BRANCH_PROTECTION.md)).

## Development setup

This project uses [FVM](https://fvm.app) with Flutter **3.29.3** (see `.fvm/fvm_config.json`).

```bash
fvm install
fvm use
fvm flutter pub get
fvm flutter test
```

See [TOOLING.md](TOOLING.md) if you hit Flutter SDK path errors.

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).

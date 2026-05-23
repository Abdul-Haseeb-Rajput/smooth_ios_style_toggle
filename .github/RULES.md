# Branch protection & contribution rules

This repo is set up for **open contributions** with a protected **`main`** branch: contributors open PRs; **only the code owner can approve** merges.

## Apply / update rules on GitHub

GitHub does **not** load these files automatically. After changing them, **import** the ruleset:

1. Open **[Settings → Rules](https://github.com/Abdul-Haseeb-Rajput/smooth_ios_style_toggle/settings/rules)**.
2. **Delete** old conflicting rulesets on `main` (e.g. duplicate PR rules).
3. **New ruleset** → **Import ruleset** → select [`.github/rulesets/main.json`](rulesets/main.json).
4. Set enforcement to **Active** → **Save**.

Also ensure **[`.github/CODEOWNERS`](CODEOWNERS)** is on `main` (required for owner-only approval).

## What [`rulesets/main.json`](rulesets/main.json) enforces

| Protection | Purpose |
| ---------- | ------- |
| **Pull request required** | No direct pushes to `main` |
| **1 approving review** | At least one approval before merge |
| **Require code owner review** | Approval must come from [CODEOWNERS](CODEOWNERS) (`@Abdul-Haseeb-Rajput`) |
| **Dismiss stale reviews** | New commits require re-approval |
| **Resolve all conversations** | Threads must be closed before merge |
| **Required check: `analyze-and-test`** | [CI workflow](workflows/ci.yml) must pass |
| **Strict status checks** | Branch must be up to date with `main` |
| **Block force-push** | No rewriting `main` history |
| **Block delete `main`** | Default branch cannot be deleted |
| **Merge methods** | Squash or rebase only (no merge commits) |

## Who can bypass?

**Repository administrators** (`actor_id: 5` in the JSON) are on the bypass list for emergencies (hotfix, release). **Contributors cannot bypass.**

## Owner workflow

1. Review contributor PRs → **Approve** when ready.
2. Merge via GitHub (squash or rebase) after CI is green.
3. For your own work: use a PR branch like everyone else, or use admin bypass only when necessary.

## First-time setup order

1. Merge or push `CODEOWNERS`, `ci.yml`, and this ruleset to `main` (may need one admin bypass or temporary rule change).
2. Import `main.json` ruleset.
3. Confirm a test PR runs **CI** and shows **review required** from code owners.

## Contributor docs

See [CONTRIBUTING.md](../CONTRIBUTING.md) and the [pull request template](pull_request_template.md).

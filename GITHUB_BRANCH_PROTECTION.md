# Protect `main` on GitHub (manual setup, no Actions)

Do this **after** you create the repo and push your code.

## 1. Open rulesets

`https://github.com/Abdul-Haseeb-Rajput/smooth_ios_style_toggle/settings/rules`

Click **New ruleset** → **New branch ruleset**.

## 2. Ruleset details

| Field | Value |
|--------|--------|
| **Ruleset name** | `Protect main` |
| **Enforcement** | Active |
| **Bypass list** | Leave empty (or add only your account if needed) |

## 3. Target branches

- **Branch target**: `Branch name` → `main`  
  (or **Default branch** if `main` is default)

## 4. Enable these rules

### Restrict updates

- **Restrict who can push to matching branches** → ON  
- Add only **Abdul-Haseeb-Rajput** (your account)

### Pull requests (optional but recommended for public repos)

- **Require a pull request before merging** → ON  
- **Required approvals** → `1` (you can approve your own if solo)  
- **Dismiss stale pull request approvals when new commits are pushed** → ON  

### History & safety

- **Require linear history** → optional  
- **Block force pushes** → ON  
- **Block deletions** → ON  

You do **not** need “Require status checks” if you are not using GitHub Actions.

## 5. Save

Click **Create** or **Save changes**.

---

## Extra security (recommended)

### Collaborators

`Settings` → `Collaborators` → remove anyone you do not trust.

### Actions (if you do not use workflows)

`Settings` → `Actions` → **General**

- **Actions permissions** → **Disable actions**  
  or **Allow local actions only**

- **Fork pull request workflows** → **Require approval for all outside collaborators**

### Dependabot (optional, no workflows required)

`Settings` → `Code security and analysis`

- **Dependency graph** → Enabled  
- **Dependabot alerts** → Enabled  

---

## What this gives you

| Others can | You can |
|------------|---------|
| Fork & clone | Push to `main` (if allowed in rules) |
| Open issues & PRs | Merge PRs after review |
| **Cannot** force-push `main` | |
| **Cannot** delete `main` | |
| **Cannot** push to `main` (unless added to bypass) | |

---

## Re-publish checklist

```powershell
cd D:\haseeb\smooth_ios_style_toggle
git init
git branch -M main
git add .
git commit -m "Initial release v0.1.1"
git remote add origin https://github.com/Abdul-Haseeb-Rajput/smooth_ios_style_toggle.git
git push -u origin main
```

Then apply this ruleset on GitHub.

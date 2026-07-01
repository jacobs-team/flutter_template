---
name: upgrade-dependencies
description: Upgrade the Flutter SDK and all dependencies to their latest compatible versions, apply migration guides for upgraded packages, bring the native Android/iOS projects up to the new SDK's template (Gradle, AGP, Kotlin, JVM targets, deployment targets), bump GitHub Actions in CI workflows, then fix analyzer issues and broken tests. Use when the user says "upgrade dependencies", "update packages", "bump deps", or "update all flutter dependencies".
---

# Upgrade the Flutter SDK and Dependencies

Bump the pinned Flutter SDK to the latest stable, upgrade every package in `pubspec.yaml` to its latest possible version, migrate the codebase for breaking changes, bring the native Android/iOS projects up to what the new SDK and plugins expect, and leave the analyzer and test suite green. Use `fvm flutter` / `fvm dart` for all CLI commands.

## Step 1: Snapshot current state

Record what you are upgrading from so the changes can be diffed later:

```
Copy-Item pubspec.lock pubspec.lock.bak
```

Also note the current Flutter version from `.fvmrc` (the `flutter` field) — this is the version CI reads, so the upgrade must update this same file.

## Step 2: Upgrade the Flutter SDK

1. Find the latest **stable** Flutter version. Use `fvm releases` (stable channel) or the release archive at `https://docs.flutter.dev/release/archive`. Stay on the stable channel — never move to beta or master.
2. Set the `flutter` field in `.fvmrc` to that exact version (a pinned version string, not `"stable"`, because CI reads it with `jq -r .flutter .fvmrc`).
3. Install and select it:

   ```
   fvm install
   fvm use <version>
   fvm flutter --version
   ```

4. If the SDK bump alone breaks `fvm flutter analyze`, treat those failures the same as dependency migrations in Step 5 (base every fix on the Flutter release notes / breaking-change docs).

## Step 3: Upgrade dependencies to latest versions

Do NOT use `pub upgrade --major-versions` — it lets the solver silently settle packages below their latest version. Instead, pin everything to latest explicitly and downgrade only what conflicts:

1. Find the latest published version of every direct dependency:

   ```
   fvm dart pub outdated --json
   ```

   Use the `latest` field for each package.

2. Edit `pubspec.yaml` and set every direct dependency in `dependencies` and `dev_dependencies` to `^<latest>`. Skip SDK-sourced entries (`flutter`, `flutter_localizations`, `flutter_test`, `flutter_web_plugins`).

3. Resolve:

   ```
   fvm flutter pub get
   ```

4. If resolution fails, read the solver's conflict output, identify the incompatibility, and downgrade the **minimal set** of packages needed to resolve it — prefer downgrading the package that blocks the fewest others, and only step down as far as the solver requires. Re-run `fvm flutter pub get` and repeat until resolution succeeds. Record every downgrade and the reason for it. Never force a version past the Dart/Flutter SDK constraint.

5. Upgrade all remaining transitive dependencies to their latest compatible versions:

   ```
   fvm flutter pub upgrade
   ```

Finally, run `fvm dart pub outdated` and report any package still behind its latest version along with what is blocking it (SDK constraint, peer dependency, discontinued, etc.). Do not force-resolve these.

## Step 4: List upgraded packages

Diff `pubspec.lock.bak` against the new `pubspec.lock` and build a table of every changed package: name, old version, new version, and whether the bump is major, minor, or patch. Delete `pubspec.lock.bak` once the list is captured.

## Step 5: Apply migrations

For each **direct** dependency that changed:

1. Fetch its changelog at `https://pub.dev/packages/<package>/changelog` (WebFetch). For major bumps also check the package README/repo for a dedicated migration guide.
2. Read every entry between the old and new version and note breaking changes, deprecations, and renamed/removed APIs.
3. Also note any **native requirement changes** in those entries — raised Android `minSdk`/`compileSdk`, new Kotlin/AGP minimums, raised iOS deployment target, Swift Package Manager or CocoaPods setup changes. Carry these into Step 6.
4. Search the codebase for affected APIs and apply the required changes. Follow the project conventions in CLAUDE.md while editing.

Do NOT guess at API changes. Base every code change on the changelog or migration guide. If neither is available, read the package's README and API docs before changing anything — never invent a new API shape from memory.

Transitive bumps need no migration unless the analyzer surfaces errors from them.

If codegen-related packages changed (`freezed`, `json_serializable`, `injectable_generator`, `build_runner`, `flutter_gen_runner`), regenerate:

```
fvm dart run build_runner build --delete-conflicting-outputs
```

## Step 6: Verify and upgrade the native projects

The Android and iOS projects go stale independently of `pubspec.yaml` — Gradle, AGP, Kotlin, JVM targets, and iOS deployment targets all drift behind what the new Flutter SDK and upgraded plugins expect. Bring them up to date every run so projects created from this template never inherit outdated native config.

1. Generate a pristine reference app with the exact new SDK in a temp directory (the scratchpad), so the diff target is what Flutter's own templates currently ship:

   ```
   fvm flutter create --project-name ref_app --platforms android,ios,web ref_app
   ```

2. Diff each of these project files against the reference and adopt the reference's tooling versions. Never downgrade a value the project already pins higher than the reference, and preserve project-specific config (flavors, `applicationId`/bundle ids, signing, ProGuard, manifest entries, icons):

   - `android/gradle/wrapper/gradle-wrapper.properties` — Gradle `distributionUrl`
   - `android/settings.gradle.kts` — AGP (`com.android.application`) and Kotlin (`org.jetbrains.kotlin.android`) plugin versions
   - `android/app/build.gradle.kts` and `android/build.gradle.kts` — `compileSdk`, `minSdk`, `targetSdk`, `ndkVersion`, Java `compileOptions`/`kotlinOptions.jvmTarget` (or `compilerOptions`)
   - `android/gradle.properties` — JVM args and AndroidX flags
   - `ios/Flutter/AppFrameworkInfo.plist` — `MinimumOSVersion`
   - `ios/Runner.xcodeproj/project.pbxproj` — every `IPHONEOS_DEPLOYMENT_TARGET` occurrence
   - `ios/Podfile` — `platform :ios` version (only if the project has a Podfile)

3. Apply the native requirements collected from plugin changelogs in Step 5. When a plugin demands more than the fresh template (for example a higher `minSdk` or iOS deployment target), raise the project to the plugin's requirement.

4. For the SDK jump itself, check `https://docs.flutter.dev/release/breaking-changes` for Android/iOS template migrations between the old and new versions (Gradle imperative-to-declarative moves, manifest changes, etc.) and apply any that affect these files.

5. Prove the Android project actually builds with the new toolchain — file diffs alone don't catch Gradle incompatibilities:

   ```
   fvm flutter build apk --debug --flavor development --target lib/main_development.dart
   ```

   On macOS also verify iOS: `fvm flutter build ios --debug --no-codesign --flavor development --target lib/main_development.dart`. On other platforms the pbxproj/plist diff plus CI is the iOS verification — say so in the report rather than skipping silently.

6. Delete the reference app once done.

## Step 7: Upgrade GitHub Actions

The workflows under `.github/workflows/` drift the same way native projects do, and stale actions eventually break on runner or Node deprecations. Bring every action reference up to its latest release so Dependabot's `github_actions` PRs have nothing left to file.

1. Collect every action reference (`uses: owner/repo@ref`) across `.github/workflows/*.yaml`, including local composite actions' workflows if present. Skip `uses:` entries that point to local paths (`./...`).

2. For each unique action, find the latest release tag:

   ```
   gh api repos/<owner>/<repo>/releases/latest --jq .tag_name
   ```

   If the repo publishes no releases, list tags instead: `gh api repos/<owner>/<repo>/tags --jq '.[].name'`.

3. Update each reference to the latest version, keeping the file's existing pin style — a project pinning `@v6` moves to `@v7`, a project pinning full SHAs gets the new tag's SHA with the version in a trailing comment.

4. For every major bump, read the release notes between the old and new major (`gh api repos/<owner>/<repo>/releases --jq '.[].body'` or the releases page) and apply any required workflow changes: renamed or removed inputs, changed defaults, new permissions, or a raised minimum runner/Node version. Do NOT guess — base every edit on the release notes, same as package migrations.

5. Also resolve runner deprecation warnings surfaced in recent runs (for example an action forced from Node 20 to 24) when a newer action major fixes them.

Action bumps cannot be executed locally. The pull request this upgrade produces runs the main CI workflow, which is the verification — call that out in the report. If open Dependabot PRs cover the same bumps, note that they become redundant once this lands.

## Step 8: Fix analyzer issues

```
fvm flutter analyze
```

Fix all **errors**, then re-run until the analyzer reports zero errors. Per project rules, leave warnings and info-level diagnostics alone unless they were introduced by this upgrade.

## Step 9: Run the test suite

```
very_good test --coverage --test-randomize-ordering-seed=random --exclude-coverage "**/*.g.dart" --exclude-coverage "**/*.freezed.dart" --exclude-coverage "lib/l10n/gen/*"
```

If Very Good CLI is not installed, install it first with `dart pub global activate very_good_cli`.

Fix any broken tests. Distinguish the two failure causes:

- Test relies on an API or behavior the upgrade changed: update the test to the new behavior.
- Upgrade genuinely broke app behavior: fix the app code, not the test.

Re-run until all tests pass and coverage stays at or above the CI minimum (100%).

## Step 10: Report

Write the summary to `UPGRADE_NOTES.md` at the repo root (when run in CI this becomes the pull request description) and also report it in chat. Include:

- The Flutter SDK version change (old → new).
- The upgraded-packages table from Step 4.
- Packages held back and why.
- A bullet per code migration applied, naming the package and the reason.
- Native project changes: every Android/iOS tooling version bumped (old → new) and which builds verified them, or an explicit note that iOS could not be built on this platform.
- GitHub Actions bumped (old → new) per workflow file, any release-note-driven config edits, and which open Dependabot PRs this supersedes.
- The final analyze / test / coverage results.

If anything could not be safely migrated, leave it pinned at the working version and explain why in `UPGRADE_NOTES.md` rather than forcing it.

## Step 11: Hand off the changes

How the changes leave your hands depends on where you are running:

**Local interactive run**: do NOT commit or push. List the changed files and a suggested commit message, and let the developer commit themselves.

**CI run** (the `GITHUB_ACTIONS` env var is set): you are the one opening the pull request.

1. Set a git identity if none is configured:

   ```
   git config user.name "github-actions[bot]"
   git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
   ```

2. If nothing changed (working tree is clean), stop here and report that everything was already current — do not open an empty PR.
3. Create the branch `chore/ai-dependency-upgrade`, commit every change with message `chore: upgrade Flutter SDK and dependencies`, and push with `--force` so a leftover branch from a previous run is replaced.
4. If no open PR exists for that branch, create one:

   ```
   gh pr create --title "chore: AI dependency + Flutter SDK upgrade" --body-file UPGRADE_NOTES.md --label dependencies
   ```

   If a PR is already open for the branch, the push updated it — just refresh its body with `gh pr edit --body-file UPGRADE_NOTES.md`.

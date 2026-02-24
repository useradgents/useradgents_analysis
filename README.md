# useradgents_analysis

[![style: useradgents analysis](https://img.shields.io/badge/style-useradgents__analysis-blue)](https://github.com/useradgents/useradgents_analysis)

Lint and DCM rules for Dart and Flutter used internally at UserAdgents.

Inspired by [very_good_analysis](https://github.com/VeryGoodOpenSource/very_good_analysis)

---

## Usage

To use this package, add `useradgents_analysis` as a dev dependency in your `pubspec.yaml`:

```yaml
dev_dependencies:
  useradgents_analysis:
    git:
      url: https://github.com/useradgents/useradgents_analysis.git
      ref: main
```

You can also pin to a specific version using a semver tag (e.g. `1.0.0`):

```yaml
dev_dependencies:
  useradgents_analysis:
    git:
      url: https://github.com/useradgents/useradgents_analysis.git
      ref: 1.0.0
```

Then, add the following to your `analysis_options.yaml`:

```yaml
include: package:useradgents_analysis/analysis_options.yaml
```

You can also add a `flutter_lints` dev dependency so your IDE can resolve the transitive include:

```yaml
dev_dependencies:
  flutter_lints: any
  useradgents_analysis:
    git:
      url: https://github.com/useradgents/useradgents_analysis.git
      ref: main
```

---

## Customization

You can disable or override specific rules in your own `analysis_options.yaml` after the include:

```yaml
include: package:useradgents_analysis/analysis_options.yaml

linter:
  rules:
    # Disable a rule from this package
    avoid_print: false

analyzer:
  errors:
    # Downgrade a rule to a warning
    missing_return: warning
```

---

## DCM (Dart Code Metrics)

This package also ships DCM rules. [DCM](https://dcm.dev/) requires a separate installation and a license key.

Install DCM via Homebrew:

```sh
brew tap CQLabs/dcm
brew install dcm
```

Then activate your license:

```sh
dcm activate --email=<your-email> --license-key=<your-key>
```

> Since DCM needs an API key to start, you can skip this part if you do not use DCM in your project. The standard Flutter lints will still apply.

---

## Versioning

This package follows [Semantic Versioning](https://semver.org/). Each version is documented in [CHANGELOG.md](./CHANGELOG.md).

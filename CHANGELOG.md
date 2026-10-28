# Changelog

## 1.2.0

- Add `sonar_report`: runs DCM and writes `dcm-quality-report.json` for SonarQube (`sonar.externalIssuesReportPaths`) with the DCM severity of each rule (`style` → MINOR, `warning`/`perf` → MAJOR, `error` → CRITICAL). The DCM `sonar` reporter sets MAJOR on every rule:
  ```sh
  dart run useradgents_analysis:sonar_report --ci-key=$DCM_CI_KEY --email=$DCM_EMAIL lib
  ```
- Disable DCM rules:
  - `prefer-prefixed-global-constants` (contrary to Effective Dart: no prefix letters)
  - `prefer-single-widget-per-file` (Flutter keeps small private widgets in the same file)
  - `prefer-spacing`, `prefer-parentheses-with-if-null` (formatting only)
- Upgrade DCM rules from `style` to `warning` (performance, recommended by the Flutter documentation): `prefer-dedicated-media-query-methods`, `prefer-declaring-const-constructor`
- Downgrade DCM rule from `warning` to `style`: `avoid-duplicate-initializers`

## 1.1.0

- Disable DCM rules:
  - `avoid-cubits`
  - `avoid-empty-setstate`
  - `avoid-enum-values-by-index`
  - `avoid-inferrable-type-arguments`
  - `avoid-missing-image-alt`
  - `avoid-missing-tr-on-strings`
  - `avoid-nullable-interpolation`
  - `check-is-not-closed-after-async-gap`
  - `extend-equatable`
  - `handle-bloc-event-subclasses`
  - `no-empty-block`
  - `prefer-nullable-provider-types`
  - `prefer-returning-shorthands`
- Downgrade DCM rules from `warning` to `style` (conventions, not bugs):
  - Bloc: `avoid-bloc-public-fields`, `avoid-empty-build-when`, `prefer-immutable-bloc-events`, `prefer-immutable-bloc-state`, `prefer-sealed-bloc-events`, `prefer-sealed-bloc-state`
  - Equatable: `prefer-equatable-mixin`
  - Flutter: `avoid-unnecessary-overrides-in-state`, `avoid-unnecessary-stateful-widgets`, `prefer-dedicated-media-query-methods`
  - General: `avoid-commented-out-code`, `avoid-redundant-async`, `avoid-unnecessary-collections`, `avoid-unnecessary-futures`, `avoid-unnecessary-local-late`, `avoid-unnecessary-nullable-return-type`, `avoid-unused-parameters`, `match-getter-setter-field-names`, `move-variable-closer-to-its-usage`, `prefer-declaring-const-constructor`, `prefer-iterable-of`, `prefer-match-file-name`, `prefer-parentheses-with-if-null`

## 1.0.0

- Initial version

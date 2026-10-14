# Changelog

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

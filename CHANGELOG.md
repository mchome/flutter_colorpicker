# CHANGELOG

## [1.1.0]

- [#75](https://github.com/mchome/flutter_colorpicker/pull/75) Enable ColorPickerInput in landscape mode.
- [#82](https://github.com/mchome/flutter_colorpicker/pull/82) Fixes Material Picker: Box shadow doesn't respect theme.
- [#101](https://github.com/mchome/flutter_colorpicker/pull/101) Fixed static analysis issues.
- [#106](https://github.com/mchome/flutter_colorpicker/pull/106) Fixed issues when running app with impeller on iOS.

## [1.0.3]

- [#68](https://github.com/mchome/flutter_colorpicker/issues/68) Fix material color picker outline for white color.
- [#69](https://github.com/mchome/flutter_colorpicker/issues/69) Fix the selector in block color picker in showDialog.

## [1.0.2]

- Fix the slider of hsv color picker in landscape mode.
- [#50](https://github.com/mchome/flutter_colorpicker/issues/50) Check the color of input in block color picker.

## [1.0.1]

- Fix late value not initialized in MaterialPicker.

## [1.0.0]

- Update shading label text style in MaterialPicker.

## [1.0.0-dev.1]

- [#21](https://github.com/mchome/flutter_colorpicker/pull/21) Add onPrimaryChanged in MaterialPicker.
- Add shading label with landscape mode in MaterialPicker.

## [1.0.0-dev.0]

- Add some new pickers like RGB palette, HUE Wheel and HUE Ring...
- Move hsv_colorpicker to colorpicker.
- [#58](https://github.com/mchome/flutter_colorpicker/issues/58) Fix the scroll problem in platform web and desktop.
- Add built-in hex input bar.
- Update example.

## [0.6.1]

- [#59](https://github.com/mchome/flutter_colorpicker/pull/59) You can modify the textStyle of label heading now.
- [#61](https://github.com/mchome/flutter_colorpicker/issues/61) Fix _setState_ was called after widget was disposed.
- This is a quick hot fix so not in git, it's fixed in v1.0.0.

## [0.6.0]

- Added **_hexInputController_** for Manual Hex Input [#31](https://github.com/mchome/flutter_colorpicker/issues/31).
- Added 122 tests and documentation for colorToHex() and colorFromHex().
- Update example app.

## [0.5.0]

- [#45](https://github.com/mchome/flutter_colorpicker/pull/36) GestureRecognizer Cleanup.
  [Reference Page](https://flutter.dev/docs/release/breaking-changes/gesture-recognizer-add-allowed-pointer).

## [0.4.0]

- Release null-safety version.

## [0.4.0-nullsafety.0]

- [#36](https://github.com/mchome/flutter_colorpicker/pull/36) Support null safety.

## [0.3.5]

- [#25](https://github.com/mchome/flutter_colorpicker/pull/25) Add MultipleChoiceBlockPicker.
  (Thanks [rostIvan](https://github.com/rostIvan))

## [0.3.4]

- [#20](https://github.com/mchome/flutter_colorpicker/pull/20) Added null control for availableColors parameter.
  (Thanks [ekangal](https://github.com/ekangal))

## [0.3.3]

- [#19](https://github.com/mchome/flutter_colorpicker/pull/19) Handle multiple GestureDetector of ColorPicker.
  (Thanks [friebetill](https://github.com/friebetill))

## [0.3.2]

- SlidePicker add indicatorBorderRadius.

## [0.3.1]

- Back compatibility for stable branch.

## [0.3.0]

- Add SlidePicker.
- Add example web support.

## [0.2.6]

- Update color selection also for tap down.

## [0.2.5]

- Fix enableLabel.
- Fix scrollbar.

## [0.2.4]

- Add hsl palette.

## [0.2.3]

- MaterialPicker: Flexible size.

## [0.2.2]

- Add didUpdateWidget lifecycle to handle changes to pickerColor.

## [0.2.1]

- Rename some types.

## [0.2.0]

- A new block color picker.
- Update example app.

## [0.1.0]

- Improve slider dragging.
- A new material color picker.
- Update example app.

## [0.0.7]

- Fix analysis warning.

## [0.0.6]

- Better landscape view.

## [0.0.5]

- Replace some deprecated functions.
- Bump SDK version.

## [0.0.4]

- Replace a parameter from `colorPainterHeight` to `pickerAreaHeightPercent` to give a ratio on the picker area.

## [0.0.3]

- Optimization for responsive design.

## [0.0.2]

- Change widget's width.

## [0.0.1+1]

- Update readme.

## [0.0.1]

- Initial release.

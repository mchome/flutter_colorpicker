import 'dart:math';

import 'package:flutter/painting.dart';

bool useWhiteForeground(Color color, {double bias: 1.0}) {
  // Old:
  // return 1.05 / (color.computeLuminance() + 0.05) > 4.5;

  // New:
  int v = sqrt(pow(color.red, 2) * 0.299 +
          pow(color.green, 2) * 0.587 +
          pow(color.blue, 2) * 0.114)
      .round();
  return v < 130 * bias ? true : false;
}

/// reference: https://en.wikipedia.org/wiki/HSL_and_HSV#HSV_to_HSL
HSLColor hsvToHsl(HSVColor color) {
  double s = 0.0;
  double l = 0.0;
  l = (2 - color.saturation) * color.value / 2;
  if (l != 0) {
    if (l == 1)
      s = 0.0;
    else if (l < 0.5)
      s = color.saturation * color.value / (l * 2);
    else
      s = color.saturation * color.value / (2 - l * 2);
  }
  return HSLColor.fromAHSL(
    color.alpha,
    color.hue,
    s.clamp(0.0, 1.0),
    l.clamp(0.0, 1.0),
  );
}

/// reference: https://en.wikipedia.org/wiki/HSL_and_HSV#HSL_to_HSV
HSVColor hslToHsv(HSLColor color) {
  double s = 0.0;
  double v = 0.0;

  v = color.lightness +
      color.saturation *
          (color.lightness < 0.5 ? color.lightness : 1 - color.lightness);
  if (v != 0) s = 2 - 2 * color.lightness / v;

  return HSVColor.fromAHSV(
    color.alpha,
    color.hue,
    s.clamp(0.0, 1.0),
    v.clamp(0.0, 1.0),
  );
}

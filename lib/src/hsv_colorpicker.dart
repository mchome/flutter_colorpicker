/// HSV(HSB)/HSL Color Picker example
///
/// You can create your own layout by importing `hsv_picker.dart`.

library hsv_colorpicker;

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/src/hsv_picker.dart';

// The default layout of Color Picker but with [HSVColor] as input.
class HsvColorPicker extends StatefulWidget {
  const HsvColorPicker({
    required this.pickerColor,
    required this.onColorChanged,
    this.paletteType: PaletteType.hsv,
    this.enableAlpha: true,
    this.showLabel: true,
    this.labelTextStyle,
    this.displayThumbColor: false,
    this.colorPickerWidth: 300.0,
    this.pickerAreaHeightPercent: 1.0,
    this.pickerAreaBorderRadius: const BorderRadius.all(Radius.zero),
  });

  final HSVColor pickerColor;
  final ValueChanged<HSVColor> onColorChanged;
  final PaletteType paletteType;
  final bool enableAlpha;
  final bool showLabel;
  final TextStyle? labelTextStyle;
  final bool displayThumbColor;
  final double colorPickerWidth;
  final double pickerAreaHeightPercent;
  final BorderRadius pickerAreaBorderRadius;

  @override
  _HsvColorPickerState createState() => _HsvColorPickerState();
}

class _HsvColorPickerState extends State<HsvColorPicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);

  @override
  void initState() {
    super.initState();
    currentHsvColor = widget.pickerColor;
  }

  @override
  void didUpdateWidget(HsvColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = widget.pickerColor;
  }

  Widget colorPickerSlider(TrackType trackType) {
    return ColorPickerSlider(
      trackType,
      currentHsvColor,
      (HSVColor color) {
        setState(() => currentHsvColor = color);
        widget.onColorChanged(currentHsvColor);
      },
      displayThumbColor: widget.displayThumbColor,
    );
  }

  Widget colorPickerArea() {
    return ClipRRect(
      borderRadius: widget.pickerAreaBorderRadius,
      child: ColorPickerArea(
        currentHsvColor,
        (HSVColor color) {
          setState(() => currentHsvColor = color);
          widget.onColorChanged(currentHsvColor);
        },
        widget.paletteType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Column(
        children: <Widget>[
          SizedBox(
            width: widget.colorPickerWidth,
            height: widget.colorPickerWidth * widget.pickerAreaHeightPercent,
            child: colorPickerArea(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 5.0, 10.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ColorIndicator(currentHsvColor),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                        width: widget.colorPickerWidth - 75.0,
                        child: colorPickerSlider(TrackType.hue),
                      ),
                      if (widget.enableAlpha)
                        SizedBox(
                          height: 40.0,
                          width: widget.colorPickerWidth - 75.0,
                          child: colorPickerSlider(TrackType.alpha),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (widget.showLabel)
            ColorPickerLabel(
              currentHsvColor,
              enableAlpha: widget.enableAlpha,
              textStyle: widget.labelTextStyle,
            ),
          SizedBox(height: 20.0),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              width: 300.0,
              height: 200.0,
              child: colorPickerArea(),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 20.0),
                  ColorIndicator(currentHsvColor),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                        width: 260.0,
                        child: colorPickerSlider(TrackType.hue),
                      ),
                      if (widget.enableAlpha)
                        SizedBox(
                          height: 40.0,
                          width: 260.0,
                          child: colorPickerSlider(TrackType.alpha),
                        ),
                    ],
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
              SizedBox(height: 20.0),
              if (widget.showLabel)
                ColorPickerLabel(
                  currentHsvColor,
                  enableAlpha: widget.enableAlpha,
                  textStyle: widget.labelTextStyle,
                ),
            ],
          ),
        ],
      );
    }
  }
}

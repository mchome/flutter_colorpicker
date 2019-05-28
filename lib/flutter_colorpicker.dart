/// HSV(HSB)/HSL color picker

library flutter_colorpicker;

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/hsv_picker.dart';

export 'package:flutter_colorpicker/hsv_picker.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    @required this.pickerColor,
    @required this.onColorChanged,
    this.paletteType: PaletteType.hsv,
    this.enableAlpha: true,
    this.enableLabel: true,
    this.displayThumbColor: false,
    this.colorPickerWidth: 300.0,
    this.pickerAreaHeightPercent: 1.0,
  });

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final PaletteType paletteType;
  final bool enableAlpha;
  final bool enableLabel;
  final bool displayThumbColor;
  final double colorPickerWidth;
  final double pickerAreaHeightPercent;

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);

  @override
  void initState() {
    super.initState();
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  @override
  void didUpdateWidget(ColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Column(
        children: <Widget>[
          SizedBox(
            width: widget.colorPickerWidth,
            height: widget.colorPickerWidth * widget.pickerAreaHeightPercent,
            child: ColorPickerArea(currentHsvColor, (HSVColor color) {
              setState(() => currentHsvColor = color);
              widget.onColorChanged(currentHsvColor.toColor());
            }, widget.paletteType),
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
                        child: ColorPickerSlider(
                          TrackType.hue,
                          currentHsvColor,
                          (HSVColor color) {
                            setState(() => currentHsvColor = color);
                            widget.onColorChanged(currentHsvColor.toColor());
                          },
                          displayThumbColor: widget.displayThumbColor,
                        ),
                      ),
                      widget.enableAlpha
                          ? SizedBox(
                              height: 40.0,
                              width: widget.colorPickerWidth - 75.0,
                              child: ColorPickerSlider(
                                TrackType.alpha,
                                currentHsvColor,
                                (HSVColor color) {
                                  setState(() => currentHsvColor = color);
                                  widget.onColorChanged(
                                      currentHsvColor.toColor());
                                },
                                displayThumbColor: widget.displayThumbColor,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget.enableLabel ? ColorPickerLabel(currentHsvColor) : SizedBox(),
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
              child: ColorPickerArea(currentHsvColor, (HSVColor color) {
                setState(() => currentHsvColor = color);
                widget.onColorChanged(currentHsvColor.toColor());
              }, widget.paletteType),
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
                        child: ColorPickerSlider(
                          TrackType.hue,
                          currentHsvColor,
                          (HSVColor color) {
                            setState(() => currentHsvColor = color);
                            widget.onColorChanged(currentHsvColor.toColor());
                          },
                          displayThumbColor: true,
                        ),
                      ),
                      widget.enableAlpha
                          ? SizedBox(
                              height: 40.0,
                              width: 260.0,
                              child: ColorPickerSlider(
                                TrackType.alpha,
                                currentHsvColor,
                                (HSVColor color) {
                                  setState(() => currentHsvColor = color);
                                  widget.onColorChanged(
                                      currentHsvColor.toColor());
                                },
                                displayThumbColor: true,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
              SizedBox(height: 20.0),
              widget.enableLabel
                  ? ColorPickerLabel(currentHsvColor)
                  : SizedBox(),
            ],
          ),
        ],
      );
    }
  }
}

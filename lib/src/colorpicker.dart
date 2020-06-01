/// HSV(HSB)/HSL Color Picker example
///
/// You can create your own layout by importing `hsv_picker.dart`.

library hsv_picker;

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/src/hsv_picker.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    @required this.pickerColor,
    @required this.onColorChanged,
    this.paletteType: PaletteType.hsv,
    this.enableAlpha: true,
    this.showLabel: true,
    this.labelTextStyle,
    this.displayThumbColor: false,
    this.colorPickerWidth: 300.0,
    this.pickerAreaHeightPercent: 1.0,
    this.pickerAreaBorderRadius: const BorderRadius.all(Radius.zero),
  })  : assert(paletteType != null),
        assert(enableAlpha != null),
        assert(showLabel != null),
        assert(pickerAreaBorderRadius != null);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final PaletteType paletteType;
  final bool enableAlpha;
  final bool showLabel;
  final TextStyle labelTextStyle;
  final bool displayThumbColor;
  final double colorPickerWidth;
  final double pickerAreaHeightPercent;
  final BorderRadius pickerAreaBorderRadius;

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

  Widget colorPickerSlider(TrackType trackType) {
    return ColorPickerSlider(
      trackType,
      currentHsvColor,
      (HSVColor color) {
        setState(() => currentHsvColor = color);
        widget.onColorChanged(currentHsvColor.toColor());
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
          widget.onColorChanged(currentHsvColor.toColor());
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

class SlidePicker extends StatefulWidget {
  const SlidePicker({
    @required this.pickerColor,
    @required this.onColorChanged,
    this.paletteType: PaletteType.hsv,
    this.enableAlpha: true,
    this.sliderSize: const Size(260, 40),
    this.showSliderText: true,
    this.sliderTextStyle,
    this.showLabel: true,
    this.labelTextStyle,
    this.showIndicator: true,
    this.indicatorSize: const Size(280, 50),
    this.indicatorAlignmentBegin: const Alignment(-1.0, -3.0),
    this.indicatorAlignmentEnd: const Alignment(1.0, 3.0),
    this.displayThumbColor: false,
    this.indicatorBorderRadius: const BorderRadius.all(Radius.zero),
  })  : assert(paletteType != null),
        assert(showSliderText != null),
        assert(enableAlpha != null),
        assert(showLabel != null),
        assert(indicatorBorderRadius != null);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final PaletteType paletteType;
  final bool enableAlpha;
  final Size sliderSize;
  final bool showSliderText;
  final TextStyle sliderTextStyle;
  final bool showLabel;
  final TextStyle labelTextStyle;
  final bool showIndicator;
  final Size indicatorSize;
  final AlignmentGeometry indicatorAlignmentBegin;
  final AlignmentGeometry indicatorAlignmentEnd;
  final bool displayThumbColor;
  final BorderRadius indicatorBorderRadius;

  @override
  State<StatefulWidget> createState() => _SlidePickerState();
}

class _SlidePickerState extends State<SlidePicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);

  @override
  void initState() {
    super.initState();
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  @override
  void didUpdateWidget(SlidePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  Widget colorPickerSlider(TrackType trackType) {
    return ColorPickerSlider(
      trackType,
      currentHsvColor,
      (HSVColor color) {
        setState(() => currentHsvColor = color);
        widget.onColorChanged(currentHsvColor.toColor());
      },
      displayThumbColor: widget.displayThumbColor,
      fullThumbColor: true,
    );
  }

  Widget indicator() {
    return ClipRRect(
      borderRadius: widget.indicatorBorderRadius,
      child: Container(
        width: widget.indicatorSize.width,
        height: widget.indicatorSize.height,
        margin: const EdgeInsets.only(bottom: 15.0),
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              widget.pickerColor,
              widget.pickerColor,
              currentHsvColor.toColor(),
              currentHsvColor.toColor(),
            ],
            begin: widget.indicatorAlignmentBegin,
            end: widget.indicatorAlignmentEnd,
            stops: [0.0, 0.5, 0.5, 1.0],
          ),
        ),
        child: const CustomPaint(painter: const CheckerPainter()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<SizedBox> sliders = [
      for (TrackType palette in [
        if (widget.paletteType == PaletteType.hsv) ...[
          TrackType.hue,
          TrackType.saturation,
          TrackType.value,
        ],
        if (widget.paletteType == PaletteType.hsl) ...[
          TrackType.hue,
          TrackType.saturationForHSL,
          TrackType.lightness,
        ],
        if (widget.paletteType == PaletteType.rgb) ...[
          TrackType.red,
          TrackType.green,
          TrackType.blue,
        ],
      ])
        SizedBox(
          width: widget.sliderSize.width,
          height: widget.sliderSize.height,
          child: Row(
            children: <Widget>[
              if (widget.showSliderText)
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    palette.toString().split('.').last[0].toUpperCase(),
                    style: widget.sliderTextStyle ??
                        Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
              Expanded(child: colorPickerSlider(palette)),
            ],
          ),
        ),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (widget.showIndicator) indicator(),
        ...sliders,
        if (widget.enableAlpha)
          SizedBox(
            height: 40.0,
            width: 260.0,
            child: colorPickerSlider(TrackType.alpha),
          ),
        SizedBox(height: 20.0),
        if (widget.showLabel)
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ColorPickerLabel(
              currentHsvColor,
              enableAlpha: widget.enableAlpha,
              textStyle: widget.labelTextStyle,
            ),
          ),
      ],
    );
  }
}

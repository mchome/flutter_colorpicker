library flutter_colorpicker;

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  ColorPicker(
      {@required this.pickerColor,
      @required this.onColorChanged,
      this.enableLabel: true,
      this.colorPickerWidth: 300.0,
      this.pickerAreaHeightPercent: 1.0});

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final bool enableLabel;
  final double colorPickerWidth;
  final double pickerAreaHeightPercent;

  final double sliderPainterHeight = 13.0;

  @override
  State<StatefulWidget> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  double hue = 0.0;
  double saturation = 0.0;
  double value = 1.0;
  double alpha = 1.0;

  List<Map<String, List<String>>> colorTypes = [
    {
      'HEX': ['R', 'G', 'B', 'A']
    },
    {
      'RGB': ['R', 'G', 'B', 'A']
    },
    {
      'HSL': ['H', 'S', 'L', 'A']
    },
  ];
  String colorType = 'HEX';
  List<String> colorValue = ['FF', 'FF', 'FF', '100'];

  Uint8List chessTexture = Uint8List(0);

  getColorValue() {
    Color color = HSVColor.fromAHSV(alpha, hue, saturation, value).toColor();
    if (color != widget.pickerColor) {
      widget.onColorChanged(color);
    }
    switch (colorType) {
      case 'HEX':
        colorValue = [
          color.red.toRadixString(16).toUpperCase(),
          color.green.toRadixString(16).toUpperCase(),
          color.blue.toRadixString(16).toUpperCase(),
          (alpha * 100).toInt().toString() + ' %'
        ];
        break;
      case 'RGB':
        colorValue = [
          color.red.toString(),
          color.green.toString(),
          color.blue.toString(),
          (alpha * 100).toInt().toString() + ' %'
        ];
        break;
      case 'HSL':
        double s = 0.0, l = 0.0;
        l = (2 - saturation) * value / 2;
        if (l != 0) {
          if (l == 1)
            s = 0.0;
          else if (l < 0.5)
            s = saturation * value / (l * 2);
          else
            s = saturation * value / (2 - l * 2);
        }
        colorValue = [
          hue.toInt().toString(),
          (s * 100).round().toString() + ' %',
          (l * 100).round().toString() + ' %',
          (alpha * 100).toInt().toString() + ' %'
        ];
        break;
      default:
        break;
    }
  }

  @override
  initState() {
    super.initState();
    String baseEncodedImage =
        'iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAIAAADZF8uwAAAAGUlEQVQYV2M4gwH+YwCGIasIUwhT25BVBADtzYNYrHvv4gAAAABJRU5ErkJggg==';
    chessTexture = base64.decode(baseEncodedImage);
    HSVColor color = HSVColor.fromColor(widget.pickerColor);
    hue = color.hue;
    saturation = color.saturation;
    value = color.value;
    alpha = color.alpha;
    getColorValue();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Orientation _orientation = MediaQuery.of(context).orientation;

    Widget colorPicker(double width) {
      double height = width * widget.pickerAreaHeightPercent;

      return Container(
        width: width,
        height: height,
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            RenderBox getBox = context.findRenderObject();
            Offset localOffset = getBox.globalToLocal(details.globalPosition);
            setState(() {
              saturation = localOffset.dx.clamp(0.0, width) / width;
              value = 1 - localOffset.dy.clamp(0.0, height) / height;
              getColorValue();
            });
          },
          child: CustomPaint(
            size: Size(width, height),
            painter: ColorPainter(hue, saturation: saturation, value: value),
          ),
        ),
      );
    }

    Widget _colorIndicator = Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(const Radius.circular(50.0)),
        border: Border.all(color: Color(0xffdddddd)),
        image: DecorationImage(
          image: MemoryImage(chessTexture),
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(const Radius.circular(50.0)),
        child: Material(
          color: HSVColor.fromAHSV(alpha, hue, saturation, value).toColor(),
        ),
      ),
    );

    Widget _pickerSlider(double width) {
      return Column(
        children: <Widget>[
          Container(
            width: width,
            height: widget.sliderPainterHeight * 3,
            child: CustomMultiChildLayout(
              delegate: _SliderLayout(),
              children: <Widget>[
                LayoutId(
                  id: _SliderLayout.painter,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(5.0)),
                    child: CustomPaint(
                      painter: HuePainter(),
                    ),
                  ),
                ),
                LayoutId(
                  id: _SliderLayout.pointer,
                  child: Transform(
                    transform: Matrix4.identity()..translate(width * hue / 360),
                    child: CustomPaint(
                      painter: HuePointerPainter(),
                    ),
                  ),
                ),
                LayoutId(
                  id: _SliderLayout.gestureContainer,
                  child: LayoutBuilder(
                    // build hue slider
                    builder: (BuildContext context, BoxConstraints box) {
                      return GestureDetector(
                        onPanUpdate: (DragUpdateDetails details) {
                          RenderBox getBox = context.findRenderObject();
                          Offset localOffset =
                              getBox.globalToLocal(details.globalPosition);
                          setState(() {
                            hue = localOffset.dx.clamp(0.0, box.maxWidth) /
                                box.maxWidth *
                                360;
                            getColorValue();
                          });
                        },
                        child: Container(
                          color: const Color(0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: width,
            height: widget.sliderPainterHeight * 3,
            child: CustomMultiChildLayout(
              delegate: _SliderLayout(),
              children: <Widget>[
                LayoutId(
                  id: _SliderLayout.painter,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(5.0)),
                    child: CustomPaint(
                      painter: AlphaPainter(),
                    ),
                  ),
                ),
                LayoutId(
                  id: _SliderLayout.pointer,
                  child: Transform(
                    transform: Matrix4.identity()..translate(width * alpha),
                    child: CustomPaint(
                      painter: AlphaPointerPainter(),
                    ),
                  ),
                ),
                LayoutId(
                  id: _SliderLayout.gestureContainer,
                  child: LayoutBuilder(
                    // build transparent slider
                    builder: (BuildContext context, BoxConstraints box) {
                      return GestureDetector(
                        onPanUpdate: (DragUpdateDetails details) {
                          RenderBox getBox = context.findRenderObject();
                          Offset localOffset =
                              getBox.globalToLocal(details.globalPosition);
                          setState(() {
                            alpha = localOffset.dx.clamp(0.0, box.maxWidth) /
                                box.maxWidth;
                            getColorValue();
                          });
                        },
                        child: Container(
                          color: const Color(0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget _pickerLabel = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DropdownButton(
          value: colorType,
          onChanged: (String val) => setState(() {
                colorType = val;
                getColorValue();
              }),
          items: colorTypes.map((Map<String, List> item) {
            return DropdownMenuItem(
              value: item.keys.map((String key) => key).first,
              child: Text(item.keys.map((String key) => key).first),
            );
          }).toList(),
        ),
      ]..addAll(colorValueLabels() ?? <Widget>[]),
    );

    switch (_orientation) {
      case Orientation.portrait:
        return Container(
          width: widget.colorPickerWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints box) {
                  return colorPicker(box.maxWidth);
                },
              ),
              Padding(padding: const EdgeInsets.all(5.0)),
              Row(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(right: 5.0)),
                  _colorIndicator,
                  Padding(padding: const EdgeInsets.only(right: 15.0)),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints box) {
                        return _pickerSlider(box.maxWidth);
                      },
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(right: 15.0)),
                ],
              ),
              Padding(padding: const EdgeInsets.all(5.0)),
              widget.enableLabel ? _pickerLabel : Container(),
            ],
          ),
        );
      case Orientation.landscape:
        return Container(
          width: widget.colorPickerWidth,
          child: Row(
            children: <Widget>[
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints box) {
                  return colorPicker(widget.colorPickerWidth / 4);
                },
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: widget.colorPickerWidth / 4,
                      child: Row(
                        children: <Widget>[
                          _colorIndicator,
                          Padding(padding: const EdgeInsets.only(right: 15.0)),
                          Expanded(
                            child: LayoutBuilder(
                              builder:
                                  (BuildContext context, BoxConstraints box) {
                                return _pickerSlider(box.maxWidth);
                              },
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(right: 15.0)),
                        ],
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(5.0)),
                    widget.enableLabel ? _pickerLabel : Container(),
                  ],
                ),
              )
            ],
          ),
        );
    }

    return Container();
  }

  List<Widget> colorValueLabels() {
    List widget = colorTypes.map((Map<String, List<String>> item) {
      if (item.keys.first == colorType) {
        return item[colorType].map((String val) {
          return Container(
            width: 43.0,
            height: 70.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(val,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                Padding(padding: const EdgeInsets.only(top: 10.0)),
                Expanded(
                  child: Text(
                    colorValue[item[colorType].indexOf(val)],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList();
      }
    }).toList();
    widget.removeWhere((v) => v == null);
    return widget.first;
  }
}

class _SliderLayout extends MultiChildLayoutDelegate {
  static final String painter = 'painter';
  static final String pointer = 'pointer';
  static final String gestureContainer = 'gesturecontainer';

  @override
  void performLayout(Size size) {
    layoutChild(painter,
        BoxConstraints.tightFor(width: size.width, height: size.height / 5));
    positionChild(painter, Offset(0.0, size.height * 0.4));
    layoutChild(
        pointer, BoxConstraints.tightFor(width: 5.0, height: size.height / 4));
    positionChild(pointer, Offset(0.0, size.height * 0.4));
    layoutChild(gestureContainer,
        BoxConstraints.tightFor(width: size.width, height: size.height));
    positionChild(gestureContainer, Offset.zero);
  }

  @override
  bool shouldRelayout(_SliderLayout oldDelegate) => false;
}

class ColorPainter extends CustomPainter {
  ColorPainter(
    this.hue, {
    this.saturation: 1.0,
    this.value: 0.0,
  });

  double hue;
  double saturation;
  double value;

  @override
  paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    Gradient gradientBW = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        HSVColor.fromAHSV(1.0, 0.0, 0.0, 1.0).toColor(),
        HSVColor.fromAHSV(1.0, 0.0, 0.0, 0.0).toColor(),
      ],
    );
    Gradient gradientColor = LinearGradient(
      colors: [
        HSVColor.fromAHSV(1.0, hue, 0.0, 1.0).toColor(),
        HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor(),
      ],
    );
    canvas.drawRect(rect, Paint()..shader = gradientBW.createShader(rect));
    canvas.drawRect(
        rect,
        Paint()
          ..blendMode = BlendMode.multiply
          ..shader = gradientColor.createShader(rect));
    canvas.drawCircle(
        Offset(size.width * saturation, size.height * (1 - value)),
        size.height * 0.04,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HuePainter extends CustomPainter {
  @override
  paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    Gradient gradient = LinearGradient(colors: [
      const HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0).toColor(),
      const HSVColor.fromAHSV(1.0, 60.0, 1.0, 1.0).toColor(),
      const HSVColor.fromAHSV(1.0, 120.0, 1.0, 1.0).toColor(),
      const HSVColor.fromAHSV(1.0, 180.0, 1.0, 1.0).toColor(),
      const HSVColor.fromAHSV(1.0, 240.0, 1.0, 1.0).toColor(),
      const HSVColor.fromAHSV(1.0, 300.0, 1.0, 1.0).toColor(),
      const HSVColor.fromAHSV(1.0, 360.0, 1.0, 1.0).toColor(),
    ]);
    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HuePointerPainter extends CustomPainter {
  @override
  paint(Canvas canvas, Size size) {
    canvas.drawShadow(
      Path()
        ..addOval(
          Rect.fromCircle(center: Offset.zero, radius: size.width * 1.8),
        ),
      Colors.black,
      4.0,
      true,
    );
    canvas.drawCircle(
        Offset(0.0, size.height * 0.4),
        size.height,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class AlphaPainter extends CustomPainter {
  @override
  paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    Gradient gradient = LinearGradient(
      colors: [
        Colors.black.withOpacity(0.0),
        Colors.black.withOpacity(1.0),
      ],
    );
    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class AlphaPointerPainter extends CustomPainter {
  @override
  paint(Canvas canvas, Size size) {
    canvas.drawShadow(
      Path()
        ..addOval(
          Rect.fromCircle(center: Offset.zero, radius: size.width * 1.8),
        ),
      Colors.black,
      4.0,
      true,
    );
    canvas.drawCircle(
        Offset(0.0, size.height * 0.4),
        size.height,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/utils.dart';

enum PaletteType { hsv, hsl }
enum TrackType { hue, saturation, value, lightness, alpha }
enum ColorModel { hex, rgb, hsv, hsl }

class HSVColorPainter extends CustomPainter {
  const HSVColorPainter(this.hsvColor);

  final HSVColor hsvColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Gradient gradientV = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white, Colors.black],
    );
    final Gradient gradientH = LinearGradient(
      colors: [
        Colors.white,
        HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 1.0).toColor(),
      ],
    );
    canvas.drawRect(rect, Paint()..shader = gradientV.createShader(rect));
    canvas.drawRect(
      rect,
      Paint()
        ..blendMode = BlendMode.multiply
        ..shader = gradientH.createShader(rect),
    );

    canvas.drawCircle(
      Offset(
          size.width * hsvColor.saturation, size.height * (1 - hsvColor.value)),
      size.height * 0.04,
      Paint()
        ..color =
            useWhiteForeground(hsvColor.toColor()) ? Colors.white : Colors.black
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HSLColorPainter extends CustomPainter {
  const HSLColorPainter(this.hslColor);

  final HSLColor hslColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Gradient gradientH = LinearGradient(
      colors: [
        const Color(0xff808080),
        HSLColor.fromAHSL(1.0, hslColor.hue, 1.0, 0.5).toColor(),
      ],
    );
    final Gradient gradientV = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 0.5, 0.5, 1],
      colors: [
        Colors.white,
        const Color(0x00ffffff),
        Colors.transparent,
        Colors.black,
      ],
    );
    canvas.drawRect(rect, Paint()..shader = gradientH.createShader(rect));
    canvas.drawRect(rect, Paint()..shader = gradientV.createShader(rect));

    canvas.drawCircle(
      Offset(size.width * hslColor.saturation,
          size.height * (1 - hslColor.lightness)),
      size.height * 0.04,
      Paint()
        ..color =
            useWhiteForeground(hslColor.toColor()) ? Colors.white : Colors.black
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _SliderLayout extends MultiChildLayoutDelegate {
  static final String track = 'track';
  static final String thumb = 'thumb';
  static final String gestureContainer = 'gesturecontainer';

  @override
  void performLayout(Size size) {
    layoutChild(
      track,
      BoxConstraints.tightFor(
        width: size.width - 30.0,
        height: size.height / 5,
      ),
    );
    positionChild(track, Offset(15.0, size.height * 0.4));
    layoutChild(
      thumb,
      BoxConstraints.tightFor(width: 5.0, height: size.height / 4),
    );
    positionChild(thumb, Offset(0.0, size.height * 0.4));
    layoutChild(
      gestureContainer,
      BoxConstraints.tightFor(width: size.width, height: size.height),
    );
    positionChild(gestureContainer, Offset.zero);
  }

  @override
  bool shouldRelayout(_SliderLayout oldDelegate) => false;
}

class TrackPainter extends CustomPainter {
  const TrackPainter(this.trackType, this.hsvColor);

  final TrackType trackType;
  final HSVColor hsvColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    if (trackType == TrackType.alpha) {
      final Size chessSize = Size(size.height / 2, size.height / 2);
      Paint chessPaintB = Paint()..color = const Color(0xffcccccc);
      Paint chessPaintW = Paint()..color = Colors.white;
      List.generate((size.height / chessSize.height).round(), (int y) {
        List.generate((size.width / chessSize.width).round(), (int x) {
          canvas.drawRect(
            Offset(chessSize.width * x, chessSize.width * y) & chessSize,
            (x + y) % 2 != 0 ? chessPaintW : chessPaintB,
          );
        });
      });
    }

    switch (trackType) {
      case TrackType.hue:
        final List<Color> colors = [
          const HSVColor.fromAHSV(1.0, 0.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 60.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 120.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 180.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 240.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 300.0, 1.0, 1.0).toColor(),
          const HSVColor.fromAHSV(1.0, 360.0, 1.0, 1.0).toColor(),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.saturation:
        final List<Color> colors = [
          HSVColor.fromAHSV(1.0, hsvColor.hue, 0.0, 1.0).toColor(),
          HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 1.0).toColor(),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.value:
        final List<Color> colors = [
          HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 0.0).toColor(),
          HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 1.0).toColor(),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.lightness:
        final List<Color> colors = [
          HSLColor.fromAHSL(1.0, hsvColor.hue, 1.0, 0.0).toColor(),
          HSLColor.fromAHSL(1.0, hsvColor.hue, 1.0, 1.0).toColor(),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
      case TrackType.alpha:
        final List<Color> colors = [
          Colors.black.withOpacity(0.0),
          Colors.black.withOpacity(1.0),
        ];
        Gradient gradient = LinearGradient(colors: colors);
        canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
        break;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ThumbPainter extends CustomPainter {
  const ThumbPainter({this.thumbColor});

  final Color thumbColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawShadow(
      Path()
        ..addOval(
          Rect.fromCircle(center: Offset(0.5, 2.0), radius: size.width * 1.8),
        ),
      Colors.black,
      3.0,
      true,
    );
    canvas.drawCircle(
        Offset(0.0, size.height * 0.4),
        size.height,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill);
    if (thumbColor != null) {
      canvas.drawCircle(
          Offset(0.0, size.height * 0.4),
          size.height * 0.65,
          Paint()
            ..color = thumbColor
            ..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class IndicatorPainter extends CustomPainter {
  const IndicatorPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Size chessSize = Size(size.width / 10, size.height / 10);
    final Paint chessPaintB = Paint()..color = const Color(0xFFCCCCCC);
    final Paint chessPaintW = Paint()..color = Colors.white;
    List.generate((size.height / chessSize.height).round(), (int y) {
      List.generate((size.width / chessSize.width).round(), (int x) {
        canvas.drawRect(
          Offset(chessSize.width * x, chessSize.height * y) & chessSize,
          (x + y) % 2 != 0 ? chessPaintW : chessPaintB,
        );
      });
    });

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        size.height / 2,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

List<String> _colorValue(HSVColor hsvColor, ColorModel colorModel) {
  final Color color = hsvColor.toColor();
  if (colorModel == ColorModel.hex) {
    return [
      color.red.toRadixString(16).toUpperCase().padLeft(2, '0'),
      color.green.toRadixString(16).toUpperCase().padLeft(2, '0'),
      color.blue.toRadixString(16).toUpperCase().padLeft(2, '0'),
      '${(color.opacity * 100).round()}%',
    ];
  } else if (colorModel == ColorModel.rgb) {
    return [
      color.red.toString(),
      color.green.toString(),
      color.blue.toString(),
      '${(color.opacity * 100).round()}%',
    ];
  } else if (colorModel == ColorModel.hsv) {
    return [
      '${hsvColor.hue.round()}°',
      '${(hsvColor.saturation * 100).round()}%',
      '${(hsvColor.value * 100).round()}%',
      '${(hsvColor.alpha * 100).round()}%',
    ];
  } else if (colorModel == ColorModel.hsl) {
    HSLColor hslColor = hsvToHsl(hsvColor);
    return [
      '${hslColor.hue.round()}°',
      '${(hslColor.saturation * 100).round()}%',
      '${(hslColor.lightness * 100).round()}%',
      '${(hsvColor.alpha * 100).round()}%',
    ];
  } else {
    return ['??', '??', '??', '??'];
  }
}

class ColorPickerLabel extends StatefulWidget {
  const ColorPickerLabel(this.hsvColor);

  final HSVColor hsvColor;

  @override
  _ColorPickerLabelState createState() => _ColorPickerLabelState();
}

class _ColorPickerLabelState extends State<ColorPickerLabel> {
  final Map<ColorModel, List<String>> _colorTypes = {
    ColorModel.hex: ['R', 'G', 'B', 'A'],
    ColorModel.rgb: ['R', 'G', 'B', 'A'],
    ColorModel.hsv: ['H', 'S', 'V', 'A'],
    ColorModel.hsl: ['H', 'S', 'L', 'A'],
  };

  ColorModel _colorType = ColorModel.hex;

  List<Widget> colorValueLabels() {
    return _colorTypes[_colorType].map((String item) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: IntrinsicHeight(
          child: Column(
            children: <Widget>[
              Text(
                item,
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: Text(
                  _colorValue(widget.hsvColor, _colorType)[
                      _colorTypes[_colorType].indexOf(item)],
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DropdownButton(
          value: _colorType,
          onChanged: (ColorModel type) => setState(() => _colorType = type),
          items: _colorTypes
              .map((ColorModel type, _) {
                return MapEntry(
                  DropdownMenuItem(
                    value: type,
                    child: Text(type.toString().split('.').last.toUpperCase()),
                  ),
                  null,
                );
              })
              .keys
              .toList(),
        ),
      ]
        ..add(SizedBox(width: 5.0))
        ..addAll(colorValueLabels() ?? <Widget>[]),
    );
  }
}

class ColorPickerSlider extends StatelessWidget {
  const ColorPickerSlider(
    this.trackType,
    this.hsvColor,
    this.onColorChanged, {
    this.displayThumbColor = false,
  });

  final TrackType trackType;
  final HSVColor hsvColor;
  final ValueChanged<HSVColor> onColorChanged;
  final bool displayThumbColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints box) {
      double thumbOffset = (box.maxWidth - 30.0) *
              (trackType == TrackType.hue
                  ? hsvColor.hue / 360
                  : hsvColor.toColor().opacity) +
          15.0;

      return CustomMultiChildLayout(
        delegate: _SliderLayout(),
        children: <Widget>[
          LayoutId(
            id: _SliderLayout.track,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(const Radius.circular(50.0)),
              child: CustomPaint(painter: TrackPainter(trackType, hsvColor)),
            ),
          ),
          LayoutId(
            id: _SliderLayout.thumb,
            child: Transform.translate(
              offset: Offset(thumbOffset, 0.0),
              child: CustomPaint(
                painter: ThumbPainter(
                  thumbColor: displayThumbColor
                      ? trackType == TrackType.hue
                          ? HSVColor.fromAHSV(1.0, hsvColor.hue, 1.0, 1.0)
                              .toColor()
                          : Colors.black.withOpacity(hsvColor.alpha)
                      : null,
                ),
              ),
            ),
          ),
          LayoutId(
            id: _SliderLayout.gestureContainer,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints box) {
                return GestureDetector(
                  onPanUpdate: (DragUpdateDetails details) {
                    RenderBox getBox = context.findRenderObject();
                    double localDx =
                        getBox.globalToLocal(details.globalPosition).dx - 15.0;
                    if (trackType == TrackType.hue) {
                      onColorChanged(hsvColor.withHue(
                          localDx.clamp(0.0, box.maxWidth - 30.0) /
                              (box.maxWidth - 30.0) *
                              360));
                    } else if (trackType == TrackType.alpha) {
                      onColorChanged(hsvColor.withAlpha(
                          localDx.clamp(0.0, box.maxWidth - 30.0) /
                              (box.maxWidth - 30.0)));
                    }
                  },
                  child: Container(color: Colors.transparent),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}

class ColorIndicator extends StatelessWidget {
  const ColorIndicator(
    this.hsvColor, {
    this.width: 50.0,
    this.height: 50.0,
  });

  final HSVColor hsvColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(const Radius.circular(1000.0)),
        border: Border.all(color: const Color(0xffdddddd)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(1000.0)),
        child: CustomPaint(painter: IndicatorPainter(hsvColor.toColor())),
      ),
    );
  }
}

class ColorPickerArea extends StatelessWidget {
  const ColorPickerArea(
    this.hsvColor,
    this.onColorChanged,
    this.paletteType,
  );

  final HSVColor hsvColor;
  final ValueChanged<HSVColor> onColorChanged;
  final PaletteType paletteType;

  void _handleColorChange(double horizontal, double vertical) {
    switch (paletteType) {
      case PaletteType.hsv:
        onColorChanged(hsvColor.withSaturation(horizontal).withValue(vertical));
        break;
      case PaletteType.hsl:
        onColorChanged(hslToHsv(hsvToHsl(hsvColor).withSaturation(horizontal).withLightness(vertical)));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

        return GestureDetector(
          onPanDown: (DragDownDetails details) {
            RenderBox getBox = context.findRenderObject();
            Offset localOffset = getBox.globalToLocal(details.globalPosition);
            double horizontal = localOffset.dx.clamp(0.0, width) / width;
            double vertical = 1 - localOffset.dy.clamp(0.0, height) / height;
            _handleColorChange(horizontal, vertical);
          },
          onPanUpdate: (DragUpdateDetails details) {
            RenderBox getBox = context.findRenderObject();
            Offset localOffset = getBox.globalToLocal(details.globalPosition);
            double horizontal = localOffset.dx.clamp(0.0, width) / width;
            double vertical = 1 - localOffset.dy.clamp(0.0, height) / height;
            _handleColorChange(horizontal, vertical);
          },
          child: Builder(
            builder: (BuildContext context) {
              switch (paletteType) {
                case PaletteType.hsv:
                  return CustomPaint(painter: HSVColorPainter(hsvColor));
                case PaletteType.hsl:
                  return CustomPaint(
                      painter: HSLColorPainter(hsvToHsl(hsvColor)));
              }
            },
          ),
        );
      },
    );
  }
}

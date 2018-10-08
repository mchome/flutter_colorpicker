/// Material color picker

library material_colorpicker;

import 'package:flutter/material.dart';

class MaterialPicker extends StatefulWidget {
  MaterialPicker({
    @required this.pickerColor,
    @required this.onColorChanged,
    this.enableLabel: false,
  });

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final bool enableLabel;

  @override
  State<StatefulWidget> createState() => _MaterialPickerState();
}

class _MaterialPickerState extends State<MaterialPicker> {
  final List<List<Color>> _colorTypes = [
    [Colors.red, Colors.redAccent],
    [Colors.pink, Colors.pinkAccent],
    [Colors.purple, Colors.purpleAccent],
    [Colors.deepPurple, Colors.deepPurpleAccent],
    [Colors.indigo, Colors.indigoAccent],
    [Colors.blue, Colors.blueAccent],
    [Colors.lightBlue, Colors.lightBlueAccent],
    [Colors.cyan, Colors.cyanAccent],
    [Colors.teal, Colors.tealAccent],
    [Colors.green, Colors.greenAccent],
    [Colors.lightGreen, Colors.lightGreenAccent],
    [Colors.lime, Colors.limeAccent],
    [Colors.yellow, Colors.yellowAccent],
    [Colors.amber, Colors.amberAccent],
    [Colors.orange, Colors.orangeAccent],
    [Colors.deepOrange, Colors.deepOrangeAccent],
    [Colors.brown],
    [Colors.grey],
    [Colors.blueGrey],
    [Colors.black],
  ];

  List<Color> _paletteTypes(List<Color> colors) {
    List<Color> result = [];

    colors.forEach((Color colorType) {
      if (colorType == Colors.grey) {
        result.addAll([
          50,
          100,
          200,
          300,
          350,
          400,
          500,
          600,
          700,
          800,
          850,
          900
        ].map((int shade) {
          return Colors.grey[shade];
        }).toList());
      } else if (colorType == Colors.black || colorType == Colors.white) {
        result.addAll([Colors.black, Colors.white]);
      } else if (colorType is MaterialAccentColor) {
        result.addAll([100, 200, 400, 700].map((int shade) {
          return colorType[shade];
        }).toList());
      } else if (colorType is MaterialColor) {
        result.addAll(
            [50, 100, 200, 300, 400, 500, 600, 700, 800, 900].map((int shade) {
          return colorType[shade];
        }).toList());
      } else {
        result.add(Color(0));
      }
    });

    return result;
  }

  List<Color> _currentColor = [Colors.red, Colors.redAccent];
  Color _currentPalette;

  @override
  initState() {
    super.initState();
    _colorTypes.forEach((List<Color> _colors) {
      _paletteTypes(_colors).forEach((Color color) {
        if (widget.pickerColor == color) {
          return setState(() {
            _currentColor = _colors;
            _currentPalette = color;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Orientation _orientation = MediaQuery.of(context).orientation;

    Widget _colorsGrid() {
      return Container(
        width: (_orientation == Orientation.portrait) ? 60.0 : null,
        height: (_orientation == Orientation.portrait) ? null : 60.0,
        decoration: BoxDecoration(
          border: (_orientation == Orientation.portrait)
              ? Border(right: BorderSide(color: Colors.grey[300], width: 1.0))
              : Border(top: BorderSide(color: Colors.grey[300], width: 1.0)),
        ),
        child: ListView(
          scrollDirection: (_orientation == Orientation.portrait)
              ? Axis.vertical
              : Axis.horizontal,
          children: [
            (_orientation == Orientation.portrait)
                ? Padding(padding: EdgeInsets.only(top: 5.0))
                : Padding(padding: EdgeInsets.only(left: 5.0))
          ]
            ..addAll(_colorTypes.map((List<Color> _colors) {
              Color _colorType = _colors[0];
              return GestureDetector(
                onTap: () => setState(() => _currentColor = _colors),
                child: Container(
                  color: Color(0),
                  padding: (_orientation == Orientation.portrait)
                      ? EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0)
                      : EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  child: Align(
                    child: Container(
                      width: 25.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                        color: _colorType,
                        borderRadius: BorderRadius.circular(60.0),
                        boxShadow: (_currentColor == _colors)
                            ? [
                                (_colorType == Theme.of(context).cardColor)
                                    ? BoxShadow(
                                        color: Colors.grey[300],
                                        blurRadius: 5.0,
                                      )
                                    : BoxShadow(
                                        color: _colorType,
                                        blurRadius: 5.0,
                                      ),
                              ]
                            : null,
                        border: (_colorType == Theme.of(context).cardColor)
                            ? Border.all(color: Colors.grey[300], width: 1.0)
                            : null,
                      ),
                    ),
                  ),
                ),
              );
            }))
            ..add((_orientation == Orientation.portrait)
                ? Padding(padding: EdgeInsets.only(top: 5.0))
                : Padding(padding: EdgeInsets.only(left: 5.0))),
        ),
      );
    }

    Widget _palettesGrid() {
      return Container(
        width: 500.0,
        child: ListView(
          scrollDirection: (_orientation == Orientation.portrait)
              ? Axis.vertical
              : Axis.horizontal,
          children: [
            (_orientation == Orientation.portrait)
                ? Padding(padding: EdgeInsets.only(top: 15.0))
                : Padding(padding: EdgeInsets.only(left: 15.0))
          ]
            ..addAll(_paletteTypes(_currentColor).map((Color _color) {
              return GestureDetector(
                onTap: () {
                  setState(() => _currentPalette = _color);
                  widget.onColorChanged(_currentPalette);
                },
                child: Container(
                  color: Color(0),
                  padding: (_orientation == Orientation.portrait)
                      ? EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0)
                      : EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  child: Align(
                    child: Container(
                      width:
                          (_orientation == Orientation.portrait) ? 250.0 : 50.0,
                      height:
                          (_orientation == Orientation.portrait) ? 50.0 : 220.0,
                      decoration: BoxDecoration(
                        color: _color,
                        boxShadow: (_currentPalette == _color)
                            ? [
                                (_color == Theme.of(context).cardColor)
                                    ? BoxShadow(
                                        color: Colors.grey[300],
                                        blurRadius: 5.0,
                                      )
                                    : BoxShadow(
                                        color: _currentPalette,
                                        blurRadius: 5.0,
                                      ),
                              ]
                            : null,
                        border: (_color == Theme.of(context).cardColor)
                            ? Border.all(color: Colors.grey[300], width: 1.0)
                            : null,
                      ),
                      child: (_orientation == Orientation.portrait &&
                              widget.enableLabel)
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '#' +
                                    (_color
                                            .toString()
                                            .replaceFirst('Color(0xff', '')
                                            .replaceFirst(')', ''))
                                        .toUpperCase() +
                                    '  ',
                                style: TextStyle(
                                  color: useWhiteForeground(_color)
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Container(),
                    ),
                  ),
                ),
              );
            }))
            ..add((_orientation == Orientation.portrait)
                ? Padding(padding: EdgeInsets.only(top: 15.0))
                : Padding(padding: EdgeInsets.only(left: 15.0))),
        ),
      );
    }

    switch (_orientation) {
      case Orientation.portrait:
        return Container(
          height: 500.0,
          child: Row(
            children: <Widget>[
              _colorsGrid(),
              Expanded(
                child: _palettesGrid(),
              ),
            ],
          ),
        );
      case Orientation.landscape:
        return Container(
          width: 500.0,
          height: 300.0,
          child: Column(
            children: <Widget>[
              Expanded(
                child: _palettesGrid(),
              ),
              _colorsGrid(),
            ],
          ),
        );
    }

    return Container();
  }
}

bool useWhiteForeground(Color color) {
  return 1.05 / (color.computeLuminance() + 0.05) > 4.5;
}

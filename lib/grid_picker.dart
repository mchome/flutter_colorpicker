/// Grid color picker

library grid_colorpicker;

import 'package:flutter/material.dart';

const List<Color> _colorTypes = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
];

class GridPicker extends StatefulWidget {
  const GridPicker({
    @required this.pickerColor,
    @required this.onColorChanged,
    this.availableColors = _colorTypes,
    this.rowCounts = 4,
    this.showHexInput = false,
  });

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color> availableColors;
  final int rowCounts;
  final bool showHexInput;

  @override
  State<StatefulWidget> createState() => _GridPickerState();
}

class _GridPickerState extends State<GridPicker> {
  Color _currentColor;
  TextEditingController _hexController = TextEditingController();

  double _viewWidth;
  double _viewHeight;

  @override
  initState() {
    super.initState();
    _currentColor = widget.pickerColor;
    _viewWidth = widget.rowCounts * 70.0;
    _viewHeight = widget.availableColors.length / widget.rowCounts * 70.0;
  }

  Widget _hexEntry() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
          title: TextField(
            textAlign: TextAlign.center,
            controller: _hexController,
          ),
          trailing: IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              int _hexValue = int.parse(_hexController.text);
              _currentColor = Color(_hexValue).withOpacity(1.0);
              widget.onColorChanged(_currentColor);
              Navigator.pop(context);
            },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    Orientation _orientation = MediaQuery.of(context).orientation;

    Widget _colorSwatch() {
      return Container(
        width:
            (_orientation == Orientation.portrait) ? _viewWidth : _viewHeight,
        height:
            (_orientation == Orientation.portrait) ? _viewHeight : _viewWidth,
        child: GridView.count(
          crossAxisCount: widget.rowCounts,
          children: []..addAll(
              widget.availableColors.map(
                (Color _color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentColor = _color;
                        widget.onColorChanged(_currentColor);
                        _hexController.text = _currentColor.value
                            .toRadixString(16)
                            .replaceFirst('FF', '')
                            .toUpperCase();
                      });
                    },
                    child: Container(
                      color: Color(0),
                      child: Align(
                        child: Container(
                          width: 45.0,
                          height: 45.0,
                          decoration: BoxDecoration(
                            color: _color,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: (_currentColor == _color)
                                ? [
                                    (_color == Theme.of(context).cardColor)
                                        ? BoxShadow(
                                            color: Colors.grey[300],
                                            blurRadius: 5.0,
                                          )
                                        : BoxShadow(
                                            color: _color,
                                            blurRadius: 5.0,
                                          ),
                                  ]
                                : null,
                            border: (_color == Theme.of(context).cardColor)
                                ? Border.all(
                                    color: Colors.grey[300], width: 1.0)
                                : null,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ),
      );
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _colorSwatch(),
          widget.showHexInput ? _hexEntry() : Container(),
        ],
      ),
    );
  }
}

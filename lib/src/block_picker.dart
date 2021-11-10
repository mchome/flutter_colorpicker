/// Blocky Color Picker

library block_colorpicker;

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/src/utils.dart';

typedef PickerItem = Widget Function(Color color);
typedef PickerLayoutBuilder = Widget Function(BuildContext context, List<Color> colors, PickerItem child);
typedef PickerItemBuilder = Widget Function(Color color, bool isCurrentColor, void Function() changeColor);

// Provide a list of colors for block color picker.
const List<Color> _defaultColors = [
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

// Provide a layout for BlockPicker.
Widget _defaultLayoutBuilder(BuildContext context, List<Color> colors, PickerItem child) {
  Orientation orientation = MediaQuery.of(context).orientation;

  return SizedBox(
    width: orientation == Orientation.portrait ? 300 : 300,
    height: orientation == Orientation.portrait ? 360 : 200,
    child: GridView.count(
      crossAxisCount: orientation == Orientation.portrait ? 4 : 6,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: colors.map((Color color) => child(color)).toList(),
    ),
  );
}

// Provide a shape for BlockPicker.
Widget _defaultItemBuilder(Color color, bool isCurrentColor, void Function() changeColor) {
  return Container(
    margin: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.8),
          offset: const Offset(1, 2),
          blurRadius: 3,
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: changeColor,
        borderRadius: BorderRadius.circular(50),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 210),
          opacity: isCurrentColor ? 1 : 0,
          child: Icon(
            Icons.done,
            color: useWhiteForeground(color) ? Colors.white : Colors.black,
          ),
        ),
      ),
    ),
  );
}

// The blocky color picker you can alter the layout and shape.
class BlockPicker extends StatefulWidget {
  const BlockPicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.availableColors = _defaultColors,
    this.layoutBuilder = _defaultLayoutBuilder,
    this.itemBuilder = _defaultItemBuilder,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color> availableColors;
  final PickerLayoutBuilder layoutBuilder;
  final PickerItemBuilder itemBuilder;

  @override
  State<StatefulWidget> createState() => _BlockPickerState();
}

class _BlockPickerState extends State<BlockPicker> {
  late Color _currentColor;

  @override
  void initState() {
    _currentColor = widget.pickerColor;
    super.initState();
  }

  void changeColor(Color color) {
    setState(() => _currentColor = color);
    widget.onColorChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder(
      context,
      widget.availableColors,
      (Color color, [bool? _, Function? __]) =>
          widget.itemBuilder(color, _currentColor.value == color.value, () => changeColor(color)),
    );
  }
}

// The blocky color picker you can alter the layout and shape with multiple choice.
class MultipleChoiceBlockPicker extends StatefulWidget {
  const MultipleChoiceBlockPicker({
    Key? key,
    required this.pickerColors,
    required this.onColorsChanged,
    this.availableColors = _defaultColors,
    this.layoutBuilder = _defaultLayoutBuilder,
    this.itemBuilder = _defaultItemBuilder,
  }) : super(key: key);

  final List<Color> pickerColors;
  final ValueChanged<List<Color>> onColorsChanged;
  final List<Color> availableColors;
  final PickerLayoutBuilder layoutBuilder;
  final PickerItemBuilder itemBuilder;

  @override
  State<StatefulWidget> createState() => _MultipleChoiceBlockPickerState();
}

class _MultipleChoiceBlockPickerState extends State<MultipleChoiceBlockPicker> {
  late List<Color> _currentColors;

  @override
  void initState() {
    _currentColors = widget.pickerColors;
    super.initState();
  }

  void toggleColor(Color color) {
    setState(() => _currentColors.contains(color) ? _currentColors.remove(color) : _currentColors.add(color));
    widget.onColorsChanged(_currentColors);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder(
      context,
      widget.availableColors,
      (Color color, [bool? _, Function? __]) => widget.itemBuilder(
        color,
        _currentColors.contains(color),
        () => toggleColor(color),
      ),
    );
  }
}

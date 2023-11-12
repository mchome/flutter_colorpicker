import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

const List<Color> colors = [
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

class BlockColorPickerExample extends StatefulWidget {
  const BlockColorPickerExample({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    required this.pickerColors,
    required this.onColorsChanged,
    required this.colorHistory,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color> pickerColors;
  final ValueChanged<List<Color>> onColorsChanged;
  final List<Color> colorHistory;

  @override
  State<BlockColorPickerExample> createState() => _BlockColorPickerExampleState();
}

class _BlockColorPickerExampleState extends State<BlockColorPickerExample> {
  int _portraitCrossAxisCount = 4;
  int _landscapeCrossAxisCount = 5;
  double _borderRadius = 30;
  double _blurRadius = 5;
  double _iconSize = 24;

  Widget pickerLayoutBuilder(BuildContext context, List<Color> colors, PickerItem child) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return SizedBox(
      width: 300,
      height: orientation == Orientation.portrait ? 360 : 240,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait ? _portraitCrossAxisCount : _landscapeCrossAxisCount,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: [for (Color color in colors) child(color)],
      ),
    );
  }

  Widget pickerItemBuilder(Color color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        color: color,
        boxShadow: [BoxShadow(color: color.withOpacity(0.8), offset: const Offset(1, 2), blurRadius: _blurRadius)],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(_borderRadius),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: isCurrentColor ? 1 : 0,
            child: Icon(
              Icons.done,
              size: _iconSize,
              color: useWhiteForeground(color) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: const EdgeInsets.all(0),
                    contentPadding: const EdgeInsets.all(25),
                    content: SingleChildScrollView(
                      child: Text(
                        '''
Widget pickerLayoutBuilder(BuildContext context, List<Color> colors, PickerItem child) {
  Orientation orientation = MediaQuery.of(context).orientation;

  return SizedBox(
    width: 300,
    height: orientation == Orientation.portrait ? 360 : 240,
    child: GridView.count(
      crossAxisCount: orientation == Orientation.portrait ? $_portraitCrossAxisCount : $_landscapeCrossAxisCount,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: [for (Color color in colors) child(color)],
    ),
  );
}
                            ''',
                      ),
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.code, color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.pickerColor,
              shadowColor: widget.pickerColor.withOpacity(1),
              elevation: 10,
            ),
          ),
        ),
        ListTile(
          title: const Text('Portrait Cross Axis Count'),
          subtitle: Text(_portraitCrossAxisCount.toString()),
          trailing: SizedBox(
            width: 200,
            child: Slider(
              value: _portraitCrossAxisCount.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: _portraitCrossAxisCount.toString(),
              onChanged: (double value) => setState(() => _portraitCrossAxisCount = value.round()),
            ),
          ),
        ),
        ListTile(
          title: const Text('Landscape Cross Axis Count'),
          subtitle: Text(_landscapeCrossAxisCount.toString()),
          trailing: SizedBox(
            width: 200,
            child: Slider(
              value: _landscapeCrossAxisCount.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: _landscapeCrossAxisCount.toString(),
              onChanged: (double value) => setState(() => _landscapeCrossAxisCount = value.round()),
            ),
          ),
        ),
        const Divider(),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: const EdgeInsets.all(0),
                    contentPadding: const EdgeInsets.all(25),
                    content: SingleChildScrollView(
                      child: Text(
                        '''
Widget pickerItemBuilder(Color color, bool isCurrentColor, void Function() changeColor) {
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular($_borderRadius),
      color: color,
      boxShadow: [BoxShadow(color: color.withOpacity(0.8), offset: const Offset(1, 2), blurRadius: $_blurRadius)],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: changeColor,
        borderRadius: BorderRadius.circular(_borderRadius),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: isCurrentColor ? 1 : 0,
          child: Icon(
            Icons.done,
            size: $_iconSize,
            color: useWhiteForeground(color) ? Colors.white : Colors.black,
          ),
        ),
      ),
    ),
  );
}
                            ''',
                      ),
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.code, color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.pickerColor,
              shadowColor: widget.pickerColor.withOpacity(1),
              elevation: 10,
            ),
          ),
        ),
        ListTile(
          title: const Text('Border Radius'),
          subtitle: Text(_borderRadius.toString()),
          trailing: SizedBox(
            width: 200,
            child: Slider(
              value: _borderRadius,
              min: 0,
              max: 30,
              divisions: 30,
              label: _borderRadius.toString(),
              onChanged: (double value) => setState(() => _borderRadius = value.round().toDouble()),
            ),
          ),
        ),
        ListTile(
          title: const Text('Blur Radius'),
          subtitle: Text(_blurRadius.toString()),
          trailing: SizedBox(
            width: 200,
            child: Slider(
              value: _blurRadius,
              min: 0,
              max: 5,
              divisions: 5,
              label: _blurRadius.toString(),
              onChanged: (double value) => setState(() => _blurRadius = value.round().toDouble()),
            ),
          ),
        ),
        ListTile(
          title: const Text('Icon Size'),
          subtitle: Text(_iconSize.toString()),
          trailing: SizedBox(
            width: 200,
            child: Slider(
              value: _iconSize,
              min: 1,
              max: 50,
              divisions: 49,
              label: _iconSize.toString(),
              onChanged: (double value) => setState(() => _iconSize = value.round().toDouble()),
            ),
          ),
        ),
        const Divider(),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Select a color'),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          availableColors: widget.colorHistory.isNotEmpty ? widget.colorHistory : colors,
                          layoutBuilder: pickerLayoutBuilder,
                          itemBuilder: pickerItemBuilder,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Blocky Color Picker',
                style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      titlePadding: EdgeInsets.all(0),
                      contentPadding: EdgeInsets.all(25),
                      content: SingleChildScrollView(
                        child: Text(
                          '''
BlockPicker(
  pickerColor: color,
  onColorChanged: changeColor,
  availableColors: colors,
  layoutBuilder: pickerLayoutBuilder,
  itemBuilder: pickerItemBuilder,
)
                          ''',
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.code, color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Select colors'),
                      content: SingleChildScrollView(
                        child: MultipleChoiceBlockPicker(
                          pickerColors: widget.pickerColors,
                          onColorsChanged: widget.onColorsChanged,
                          availableColors: widget.colorHistory.isNotEmpty ? widget.colorHistory : colors,
                          layoutBuilder: pickerLayoutBuilder,
                          itemBuilder: pickerItemBuilder,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Multiple selection Blocky Color Picker',
                style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      titlePadding: EdgeInsets.all(0),
                      contentPadding: EdgeInsets.all(25),
                      content: SingleChildScrollView(
                        child: Text(
                          '''
MultipleChoiceBlockPicker(
  pickerColors: colors,
  onColorsChanged: changeColors,
  availableColors: colors,
  layoutBuilder: pickerLayoutBuilder,
  itemBuilder: pickerItemBuilder,
)
                          ''',
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.code, color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

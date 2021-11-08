import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class BlockColorPickerExample extends StatefulWidget {
  const BlockColorPickerExample({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;

  @override
  State<BlockColorPickerExample> createState() => _BlockColorPickerExampleState();
}

class _BlockColorPickerExampleState extends State<BlockColorPickerExample> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
                primary: widget.pickerColor,
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
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
          ],
        ),
        // SwitchListTile(
        //   title: const Text('Enable Label in Portrait Mode'),
        //   value: _enableLabel,
        //   onChanged: (bool value) => setState(() => _enableLabel = !_enableLabel),
        // ),
        const Divider(),
      ],
    );
  }
}

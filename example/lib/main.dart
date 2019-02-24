import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_colorpicker/utils.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Example',
      theme: ThemeData(primaryColor: Colors.blue),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color currentColor = const Color(0xff443a49);

  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColorAndPopout(Color color) => setState(() {
        currentColor = color;
        Timer(const Duration(milliseconds: 500),
            () => Navigator.of(context).pop());
      });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Color Picker Example'),
          bottom: TabBar(
            tabs: <Widget>[
              const Tab(text: 'HSV(Rect)'),
              const Tab(text: 'Material'),
              const Tab(text: 'Block'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: RaisedButton(
                elevation: 3.0,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        titlePadding: const EdgeInsets.all(0.0),
                        contentPadding: const EdgeInsets.all(0.0),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: currentColor,
                            onColorChanged: changeColor,
                            colorPickerWidth: 1000.0,
                            pickerAreaHeightPercent: 0.7,
                            enableAlpha: true,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Change me'),
                color: currentColor,
                textColor: useWhiteForeground(currentColor)
                    ? const Color(0xffffffff)
                    : const Color(0xff000000),
              ),
            ),
            Center(
              child: RaisedButton(
                elevation: 3.0,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        titlePadding: const EdgeInsets.all(0.0),
                        contentPadding: const EdgeInsets.all(0.0),
                        content: SingleChildScrollView(
                          child: MaterialPicker(
                            pickerColor: currentColor,
                            onColorChanged: changeColorAndPopout,
                            enableLabel: true,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Change me'),
                color: currentColor,
                textColor: useWhiteForeground(currentColor)
                    ? const Color(0xffffffff)
                    : const Color(0xff000000),
              ),
            ),
            Center(
              child: RaisedButton(
                elevation: 3.0,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Select a color'),
                        content: SingleChildScrollView(
                          child: BlockPicker(
                            pickerColor: currentColor,
                            onColorChanged: changeColor,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Change me'),
                color: currentColor,
                textColor: useWhiteForeground(currentColor)
                    ? const Color(0xffffffff)
                    : const Color(0xff000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

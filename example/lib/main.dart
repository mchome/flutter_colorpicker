import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:flutter_colorpicker/grid_picker.dart';
import 'package:flutter_colorpicker/utils.dart';

main() => runApp(
      MaterialApp(
        title: 'Flutter Example',
        theme: ThemeData(primaryColor: Colors.blue),
        home: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color currentColor = Color(0xff443a49);

  ValueChanged<Color> onColorChanged;

  changeColor(Color color) => setState(() => currentColor = color);
  changeColorAndPopout(Color color) => setState(() {
        currentColor = color;
        Navigator.of(context).pop();
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
              Tab(text: 'HSV(Rect)'),
              Tab(text: 'Material'),
              Tab(text: 'Grid'),
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
                        titlePadding: EdgeInsets.all(0.0),
                        contentPadding: EdgeInsets.all(0.0),
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
                child: Text('Change me'),
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
                        titlePadding: EdgeInsets.all(0.0),
                        contentPadding: EdgeInsets.all(0.0),
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
                child: Text('Change me'),
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
                        titlePadding: EdgeInsets.all(0.0),
                        contentPadding: EdgeInsets.all(0.0),
                        content: SingleChildScrollView(
                          child: GridPicker(
                            pickerColor: currentColor,
                            onColorChanged: changeColor,
                            showHexInput: true,
                            rowCounts: 4,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text('Change me'),
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

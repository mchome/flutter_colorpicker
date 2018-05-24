import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

main() => runApp(
      new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: const Text('Flutter Color Picker Example'),
          ),
          body: new MyApp(),
        ),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color pickerColor = new Color(0xff443a49);
  Color currentColor = new Color(0xff443a49);

  ValueChanged<Color> onColorChanged;

  changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new RaisedButton(
        elevation: 3.0,
        onPressed: () {
          pickerColor = currentColor;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return new AlertDialog(
                title: const Text('Pick a color!'),
                content: new SingleChildScrollView(
                  child: new ColorPicker(
                    pickerColor: pickerColor,
                    onColorChanged: changeColor,
                    colorPickerWidth: 1000.0,
                    pickerAreaHeightPercent: 0.7,
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text('Got it'),
                    onPressed: () {
                      setState(() => currentColor = pickerColor);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: new Text('Change me'),
        color: currentColor,
        textColor: const Color(0xffffffff),
      ),
    );
  }
}

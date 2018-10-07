import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Color Picker Example'),
          ),
          body: MyApp(),
        ),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  ValueChanged<Color> onColorChanged;

  changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        elevation: 3.0,
        onPressed: () {
          pickerColor = currentColor;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: EdgeInsets.all(0.0),
                contentPadding: EdgeInsets.all(0.0),
                title: Container(
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: const Text(
                      'Pick a color!',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                  padding: EdgeInsets.all(20.0),
                ),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: pickerColor,
                    onColorChanged: changeColor,
                    colorPickerWidth: 1000.0,
                    pickerAreaHeightPercent: 0.7,
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Got it'),
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
        child: Text('Change me'),
        color: currentColor,
        textColor: const Color(0xffffffff),
      ),
    );
  }
}

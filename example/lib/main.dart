import 'package:flutter/cupertino.dart' show CupertinoTextField;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/foundation.dart'
//     show debugDefaultTargetPlatformOverride;

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  // debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool lightTheme = true;
  Color currentColor = Colors.limeAccent;
  List<Color> currentColors = [Colors.limeAccent, Colors.green];

  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) => setState(() => currentColors = colors);

  // Just an example of how to use/interpret/format text input's result.
  Future<void> copyToClipboard(String input) async {
    late String textToCopy;
    final hex = input.toUpperCase();
    if (hex.startsWith('FF') && hex.length == 8) {
      textToCopy = hex.replaceFirst('FF', '');
    } else {
      textToCopy = hex;
    }
    await Clipboard.setData(ClipboardData(text: '#$textToCopy'));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: lightTheme ? ThemeData.light() : ThemeData.dark(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: GestureDetector(
              child: Text('Flutter Color Picker Example'),
              onDoubleTap: () => setState(() => lightTheme = !lightTheme),
            ),
            bottom: TabBar(
              tabs: <Widget>[
                const Tab(text: 'HSV'),
                const Tab(text: 'Material'),
                const Tab(text: 'Block'),
              ],
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
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
                                colorPickerWidth: 300.0,
                                pickerAreaHeightPercent: 0.7,
                                enableAlpha: true,
                                displayThumbColor: true,
                                showLabel: true,
                                paletteType: PaletteType.hsv,
                                pickerAreaBorderRadius: const BorderRadius.only(
                                  topLeft: const Radius.circular(2.0),
                                  topRight: const Radius.circular(2.0),
                                ),
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
                  RaisedButton(
                    elevation: 3.0,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(0.0),
                            contentPadding: const EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            content: SingleChildScrollView(
                              child: SlidePicker(
                                pickerColor: currentColor,
                                onColorChanged: changeColor,
                                paletteType: PaletteType.rgb,
                                enableAlpha: false,
                                displayThumbColor: true,
                                showLabel: false,
                                showIndicator: true,
                                indicatorBorderRadius:
                                    const BorderRadius.vertical(
                                  top: const Radius.circular(25.0),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Change me again'),
                    color: currentColor,
                    textColor: useWhiteForeground(currentColor)
                        ? const Color(0xffffffff)
                        : const Color(0xff000000),
                  ),
                  MaterialButton(
                    elevation: 3.0,
                    onPressed: () {
                      // The initial value can be provided directly to the controller.
                      final textController =
                          TextEditingController(text: '#2F19DB');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            titlePadding: const EdgeInsets.all(0.0),
                            contentPadding: const EdgeInsets.all(0.0),
                            content: Column(
                              children: [
                                ColorPicker(
                                  pickerColor: currentColor,
                                  onColorChanged: changeColor,
                                  colorPickerWidth: 300.0,
                                  pickerAreaHeightPercent: 0.7,
                                  enableAlpha:
                                      true, // hexInputController will respect it too.
                                  displayThumbColor: true,
                                  showLabel: true,
                                  paletteType: PaletteType.hsv,
                                  pickerAreaBorderRadius: const BorderRadius.only(
                                    topLeft: const Radius.circular(2.0),
                                    topRight: const Radius.circular(2.0),
                                  ),
                                  hexInputController: textController, // <- here
                                  portraitOnly: true,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  /* It can be any text field, for example:

                                  * TextField
                                  * TextFormField
                                  * CupertinoTextField
                                  * EditableText
                                  * any text field from 3-rd party package
                                  * your own text field

                                  so basically anything that supports/uses
                                  a TextEditingController for an editable text.
                                  */
                                  child: CupertinoTextField(
                                    controller: textController,
                                    // Everything below is purely optional.
                                    prefix: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: const Icon(Icons.tag),
                                    ),
                                    suffix: IconButton(
                                      icon:
                                          const Icon(Icons.content_paste_rounded),
                                      onPressed: () async =>
                                          copyToClipboard(textController.text),
                                    ),
                                    autofocus: true,
                                    maxLength: 9,
                                    inputFormatters: [
                                      // Any custom input formatter can be passed
                                      // here or use any Form validator you want.
                                      UpperCaseTextFormatter(),
                                      FilteringTextInputFormatter.allow(
                                          RegExp(kValidHexPattern)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Change me via text input'),
                    color: currentColor,
                    textColor: useWhiteForeground(currentColor)
                        ? const Color(0xffffffff)
                        : const Color(0xff000000),
                  ),
                ],
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
                              onColorChanged: changeColor,
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
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
                      RaisedButton(
                        elevation: 3.0,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Select colors'),
                                content: SingleChildScrollView(
                                  child: MultipleChoiceBlockPicker(
                                    pickerColors: currentColors,
                                    onColorsChanged: changeColors,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text('Change me again'),
                        color: currentColor,
                        textColor: useWhiteForeground(currentColor)
                            ? const Color(0xffffffff)
                            : const Color(0xff000000),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(_, TextEditingValue nv) =>
      TextEditingValue(text: nv.text.toUpperCase(), selection: nv.selection);
}

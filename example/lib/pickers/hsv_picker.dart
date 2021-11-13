import 'package:flutter/cupertino.dart' show CupertinoTextField;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// Just an example of how to use/interpret/format text input's result.
void copyToClipboard(String input) {
  String textToCopy = input.replaceFirst('#', '').toUpperCase();
  if (textToCopy.startsWith('FF') && textToCopy.length == 8) {
    textToCopy = textToCopy.replaceFirst('FF', '');
  }
  Clipboard.setData(ClipboardData(text: '#$textToCopy'));
}

class HSVColorPickerExample extends StatefulWidget {
  const HSVColorPickerExample({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.colorHistory,
    this.onHistoryChanged,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color>? colorHistory;
  final ValueChanged<List<Color>>? onHistoryChanged;

  @override
  State<HSVColorPickerExample> createState() => _HSVColorPickerExampleState();
}

class _HSVColorPickerExampleState extends State<HSVColorPickerExample> {
  // Picker 1
  PaletteType _paletteType = PaletteType.hsl;
  bool _enableAlpha = true;
  bool _displayThumbColor = true;
  final List<ColorLabelType> _labelTypes = [ColorLabelType.hsl, ColorLabelType.hsv];
  bool _displayHexInputBar = false;

  // Picker 2
  bool _displayThumbColor2 = true;
  bool _enableAlpha2 = false;

  // Picker 3
  ColorModel _colorModel = ColorModel.rgb;
  bool _enableAlpha3 = false;
  bool _displayThumbColor3 = true;
  bool _showParams = true;
  bool _showIndicator = true;

  // Picker 4
  final textController =
      TextEditingController(text: '#2F19DB'); // The initial value can be provided directly to the controller.
  bool _enableAlpha4 = true;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

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
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          colorPickerWidth: 300,
                          pickerAreaHeightPercent: 0.7,
                          enableAlpha: _enableAlpha,
                          labelTypes: _labelTypes,
                          displayThumbColor: _displayThumbColor,
                          paletteType: _paletteType,
                          pickerAreaBorderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(2),
                            topRight: Radius.circular(2),
                          ),
                          hexInputBar: _displayHexInputBar,
                          colorHistory: widget.colorHistory,
                          onHistoryChanged: widget.onHistoryChanged,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Color Picker with Slider',
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
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Text(
                          '''
ColorPicker(
  pickerColor: color,
  onColorChanged: changeColor,
  colorPickerWidth: 300,
  pickerAreaHeightPercent: 0.7,
  enableAlpha: $_enableAlpha,
  labelTypes: $_labelTypes,
  displayThumbColor: $_displayThumbColor,
  paletteType: $_paletteType,
  pickerAreaBorderRadius: const BorderRadius.only(
    topLeft: Radius.circular(2),
    topRight: Radius.circular(2),
  ),
  hexInputBar: $_displayHexInputBar,
  colorHistory: colorHistory,
  onHistoryChanged: changeColorHistory,
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
        SwitchListTile(
          title: const Text('Enable Alpha Slider'),
          subtitle: const Text('Display alpha slider & label text'),
          value: _enableAlpha,
          onChanged: (bool value) => setState(() => _enableAlpha = !_enableAlpha),
        ),
        SwitchListTile(
          title: const Text('Display Thumb Color in slider'),
          value: _displayThumbColor,
          onChanged: (bool value) => setState(() => _displayThumbColor = !_displayThumbColor),
        ),
        ListTile(
          title: const Text('Palette Type'),
          trailing: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _paletteType,
              onChanged: (PaletteType? type) {
                if (type != null) setState(() => _paletteType = type);
              },
              items: [
                for (PaletteType type in PaletteType.values)
                  DropdownMenuItem(
                    value: type,
                    child: SizedBox(
                      width: 150,
                      child: Text(type.toString().split('.').last, textAlign: TextAlign.end),
                    ),
                  )
              ],
            ),
          ),
        ),
        ExpansionTile(
          title: Text(_labelTypes.isNotEmpty ? 'Display Label' : 'Disable Label'),
          subtitle: Text(
            _labelTypes.isNotEmpty ? _labelTypes.map((e) => e.toString().split('.').last.toUpperCase()).toString() : '',
          ),
          children: [
            SwitchListTile(
              title: const Text('    Display HEX Label Text'),
              value: _labelTypes.contains(ColorLabelType.hex),
              onChanged: (bool value) => setState(
                () => value ? _labelTypes.add(ColorLabelType.hex) : _labelTypes.remove(ColorLabelType.hex),
              ),
              dense: true,
            ),
            SwitchListTile(
              title: const Text('    Display RGB Label Text'),
              value: _labelTypes.contains(ColorLabelType.rgb),
              onChanged: (bool value) => setState(
                () => value ? _labelTypes.add(ColorLabelType.rgb) : _labelTypes.remove(ColorLabelType.rgb),
              ),
              dense: true,
            ),
            SwitchListTile(
              title: const Text('    Display HSV Label Text'),
              value: _labelTypes.contains(ColorLabelType.hsv),
              onChanged: (bool value) => setState(
                () => value ? _labelTypes.add(ColorLabelType.hsv) : _labelTypes.remove(ColorLabelType.hsv),
              ),
              dense: true,
            ),
            SwitchListTile(
              title: const Text('    Display HSL Label Text'),
              value: _labelTypes.contains(ColorLabelType.hsl),
              onChanged: (bool value) => setState(
                () => value ? _labelTypes.add(ColorLabelType.hsl) : _labelTypes.remove(ColorLabelType.hsl),
              ),
              dense: true,
            ),
          ],
        ),
        SwitchListTile(
          title: const Text('Display Hex Input Bar'),
          value: _displayHexInputBar,
          onChanged: (bool value) => setState(() => _displayHexInputBar = !_displayHexInputBar),
        ),
        const Divider(),
        const SizedBox(height: 5),
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
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: MediaQuery.of(context).orientation == Orientation.portrait
                            ? const BorderRadius.vertical(
                                top: Radius.circular(500),
                                bottom: Radius.circular(100),
                              )
                            : const BorderRadius.horizontal(right: Radius.circular(500)),
                      ),
                      content: SingleChildScrollView(
                        child: HueRingPicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          enableAlpha: _enableAlpha2,
                          displayThumbColor: _displayThumbColor2,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Hue Ring Picker with Hex Input',
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
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Text(
                          '''
HueRingPicker(
  pickerColor: color,
  onColorChanged: changeColor,
  enableAlpha: $_enableAlpha2,
  displayThumbColor: $_displayThumbColor2,
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
        SwitchListTile(
          title: const Text('Enable Alpha Slider'),
          value: _enableAlpha2,
          onChanged: (bool value) => setState(() => _enableAlpha2 = !_enableAlpha2),
        ),
        SwitchListTile(
          title: const Text('Display Thumb Color in Slider'),
          value: _displayThumbColor2,
          onChanged: (bool value) => setState(() => _displayThumbColor2 = !_displayThumbColor2),
        ),
        const Divider(),
        const SizedBox(height: 5),
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
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                      content: SingleChildScrollView(
                        child: SlidePicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          colorModel: _colorModel,
                          enableAlpha: _enableAlpha3,
                          displayThumbColor: _displayThumbColor3,
                          showParams: _showParams,
                          showIndicator: _showIndicator,
                          indicatorBorderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Slider-only Color Picker',
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
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Text(
                          '''
SlidePicker(
  pickerColor: color,
  onColorChanged: changeColor,
  colorModel: $_colorModel,
  enableAlpha: $_enableAlpha3,
  displayThumbColor: $_displayThumbColor3,
  showParams: $_showParams,
  showIndicator: $_showIndicator,
  indicatorBorderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
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
        ListTile(
          title: const Text('Color Model'),
          trailing: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _colorModel,
              onChanged: (ColorModel? type) {
                if (type != null) setState(() => _colorModel = type);
              },
              items: [
                for (ColorModel type in ColorModel.values)
                  DropdownMenuItem(
                    value: type,
                    child: SizedBox(
                      width: 50,
                      child: Text(type.toString().split('.').last, textAlign: TextAlign.end),
                    ),
                  )
              ],
            ),
          ),
        ),
        SwitchListTile(
          title: const Text('Enable Alpha Slider'),
          value: _enableAlpha3,
          onChanged: (bool value) => setState(() => _enableAlpha3 = !_enableAlpha3),
        ),
        SwitchListTile(
          title: const Text('Display Thumb Color in Slider'),
          value: _displayThumbColor3,
          onChanged: (bool value) => setState(() => _displayThumbColor3 = !_displayThumbColor3),
        ),
        SwitchListTile(
          title: const Text('Show Parameters next to Slider'),
          value: _showParams,
          onChanged: (bool value) => setState(() => _showParams = !_showParams),
        ),
        SwitchListTile(
          title: const Text('Show Color Indicator'),
          value: _showIndicator,
          onChanged: (bool value) => setState(() => _showIndicator = !_showIndicator),
        ),
        const Divider(),
        const SizedBox(height: 15),
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
                      scrollable: true,
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      content: Column(
                        children: [
                          ColorPicker(
                            pickerColor: widget.pickerColor,
                            onColorChanged: widget.onColorChanged,
                            colorPickerWidth: 300,
                            pickerAreaHeightPercent: 0.7,
                            enableAlpha: _enableAlpha4, // hexInputController will respect it too.
                            displayThumbColor: true,
                            paletteType: PaletteType.hsvWithHue,
                            labelTypes: const [],
                            pickerAreaBorderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(2),
                              topRight: Radius.circular(2),
                            ),
                            hexInputController: textController, // <- here
                            portraitOnly: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                              prefix: const Padding(padding: EdgeInsets.only(left: 8), child: Icon(Icons.tag)),
                              suffix: IconButton(
                                icon: const Icon(Icons.content_paste_rounded),
                                onPressed: () => copyToClipboard(textController.text),
                              ),
                              autofocus: true,
                              maxLength: 9,
                              inputFormatters: [
                                // Any custom input formatter can be passed
                                // here or use any Form validator you want.
                                UpperCaseTextFormatter(),
                                FilteringTextInputFormatter.allow(RegExp(kValidHexPattern)),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text(
                '  HSV Color Picker\n(Your own text field)',
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
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Text(
                          '''
Column(
  children: [
    ColorPicker(
      pickerColor: color,
      onColorChanged: changeColor,
      colorPickerWidth: 300,
      pickerAreaHeightPercent: 0.7,
      enableAlpha: $_enableAlpha4,
      displayThumbColor: true,
      paletteType: PaletteType.hsvWithHue,
      labelTypes: const [],
      pickerAreaBorderRadius: const BorderRadius.only(
        topLeft: Radius.circular(2),
        topRight: Radius.circular(2),
      ),
      hexInputController: textController,
      portraitOnly: true,
    ),
    Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: CupertinoTextField(
        controller: textController,
        prefix: const Padding(padding: EdgeInsets.only(left: 8), child: Icon(Icons.tag)),
        suffix: IconButton(
          icon: const Icon(Icons.content_paste_rounded),
          onPressed: () => copyToClipboard(textController.text),
        ),
        autofocus: true,
        maxLength: 9,
        inputFormatters: [
          UpperCaseTextFormatter(),
          FilteringTextInputFormatter.allow(RegExp(kValidHexPattern)),
        ],
      ),
    )
  ],
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
        SwitchListTile(
          title: const Text('Enable Alpha Slider'),
          value: _enableAlpha4,
          onChanged: (bool value) => setState(() => _enableAlpha4 = !_enableAlpha4),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

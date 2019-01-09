# flutter_colorpicker

[![pub package](https://img.shields.io/pub/v/flutter_colorpicker.svg)](https://pub.dartlang.org/packages/flutter_colorpicker)

A HSV color picker inspired by chrome devtools and a material color picker for your flutter app.

## Getting Started

### Installation

Add this to your pubspec.yaml (or create it):

```yaml
dependencies:
  flutter_colorpicker: any
```

Then run the flutter tooling:

```bash
flutter packages get
```

Or upgrade the packages with:

```bash
flutter packages upgrade
```

### Example

Use it in [showDialog] widget:

```dart
// create some value
Color pickerColor = Color(0xff443a49);
Color currentColor = Color(0xff443a49);
ValueChanged<Color> onColorChanged;

// bind some values with [ValueChanged<Color>] callback
changeColor(Color color) {
  setState(() => pickerColor = color);
}

// raise the [showDialog] widget
showDialog(
  context: context,
  child: AlertDialog(
    title: const Text('Pick a color!'),
    content: SingleChildScrollView(
      child: ColorPicker(
        pickerColor: pickerColor,
        onColorChanged: changeColor,
        enableLabel: true,
        pickerAreaHeightPercent: 0.8,
      ),
      // Use Material color picker
      // child: MaterialPicker(
      //   pickerColor: pickerColor,
      //   onColorChanged: changeColor,
      //   enableLabel: true, // only on portrait mode
      // ),
      //
      // Use Block color picker
      // child: BlockPicker(
      //   pickerColor: currentColor,
      //   onColorChanged: changeColor,
      // ),
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
  ),
)
```

![preview](https://user-images.githubusercontent.com/7392658/36585408-bb4e96a4-18b8-11e8-8c20-d4dc200e1a7c.gif)

![01](https://user-images.githubusercontent.com/7392658/46619114-de790f80-cb53-11e8-81c8-278d4dc51606.png)
![02](https://user-images.githubusercontent.com/7392658/46619116-df11a600-cb53-11e8-8b6b-4e495f8dbea9.png)
![03](https://user-images.githubusercontent.com/7392658/46619111-dd47e280-cb53-11e8-9701-38900857321f.png)
![04](https://user-images.githubusercontent.com/7392658/46619112-dde07900-cb53-11e8-91d9-a4d1ee70cf3b.png)
![05](https://user-images.githubusercontent.com/7392658/50912123-56fdae00-146c-11e9-8d63-be3a26a20b72.png)

Details in [example/](https://github.com/mchome/flutter_colorpicker/tree/master/example) folder.

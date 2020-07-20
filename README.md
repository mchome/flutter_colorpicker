# flutter_colorpicker

[![pub package](https://img.shields.io/pub/v/flutter_colorpicker.svg)](https://pub.dev/packages/flutter_colorpicker)

A HSV(HSB)/HSL color picker inspired by chrome devtools and a material color picker for your flutter app.

[Web Example](https://mchome.github.io/flutter_colorpicker)

## Getting Started

Use it in [showDialog] widget:

```dart
// create some values
Color pickerColor = Color(0xff443a49);
Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
void changeColor(Color color) {
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
        showLabel: true,
        pickerAreaHeightPercent: 0.8,
      ),
      // Use Material color picker:
      //
      // child: MaterialPicker(
      //   pickerColor: pickerColor,
      //   onColorChanged: changeColor,
      //   showLabel: true, // only on portrait mode
      // ),
      //
      // Use Block color picker:
      //
      // child: BlockPicker(
      //   pickerColor: currentColor,
      //   onColorChanged: changeColor,
      // ),
      //
      // child: MultipleChoiceBlockPicker(
      //   pickerColors: currentColors,
      //   onColorsChanged: changeColors,
      // ),
    ),
    actions: <Widget>[
      FlatButton(
        child: const Text('Got it'),
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
![SlidePicker](https://user-images.githubusercontent.com/7392658/74600957-5efa3980-50d3-11ea-9458-55842927e565.png)

<!-- markdownlint-disable MD033 -->
<img src="https://user-images.githubusercontent.com/7392658/46619114-de790f80-cb53-11e8-81c8-278d4dc51606.png" width="23%">
<img src="https://user-images.githubusercontent.com/7392658/57980467-c577fb80-7a5e-11e9-85ee-033963b48162.png" width="23%">
<img src="https://user-images.githubusercontent.com/7392658/46619111-dd47e280-cb53-11e8-9701-38900857321f.png" width="23%">
<img src="https://user-images.githubusercontent.com/7392658/50912123-56fdae00-146c-11e9-8d63-be3a26a20b72.png" width="23%">
<img src="https://user-images.githubusercontent.com/7392658/46619116-df11a600-cb53-11e8-8b6b-4e495f8dbea9.png" width="23%">
<img src="https://user-images.githubusercontent.com/7392658/57980469-c6109200-7a5e-11e9-8c32-5f4ba74c88da.png" width="23%">
<img src="https://user-images.githubusercontent.com/7392658/46619112-dde07900-cb53-11e8-91d9-a4d1ee70cf3b.png" width="23%">
<img src="https://user-images.githubusercontent.com/7392658/57980462-b8f3a300-7a5e-11e9-95e4-1748b14793ae.png" width="23%">

Details in [example/](https://github.com/mchome/flutter_colorpicker/tree/master/example) folder.

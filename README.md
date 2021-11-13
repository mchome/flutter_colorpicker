# flutter_colorpicker

[![pub package](https://img.shields.io/pub/v/flutter_colorpicker?include_prereleases.svg "Flutter Color Picker")](https://pub.dev/packages/flutter_colorpicker)
[![badge](https://img.shields.io/badge/%20built%20with-%20%E2%9D%A4-ff69b4.svg "build with love")](https://github.com/mchome/flutter_colorpicker)

HSV(HSB)/HSL/RGB/Material color picker inspired by all the good design for your amazing flutter apps.  
Adorable color pickers out of the box with highly customized widgets to all developers' needs.

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
      ElevatedButton(
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
<img src="https://user-images.githubusercontent.com/7392658/141606774-8193f4ee-e40d-49fc-b081-261c72325bf8.png">

Details in [example](https://github.com/mchome/flutter_colorpicker/tree/master/example) folder.

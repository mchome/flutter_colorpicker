import 'dart:ui' show Color;

import 'package:flutter_colorpicker/src/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test colorFromHex:', () {
    group('Valid formats test:', () {
      const Set<String> valid6digits = {'aBc', '#aBc', 'aaBBcc', '#aaBBcc'}, valid8digits = {'00aaBBcc', '#00aaBBcc'};

      const Color expectedColor = Color(0xffaabbcc), expectedColorTransparent = Color(0x00aabbcc);

      for (var format in valid6digits) {
        test(
          'It should accept text input with a format: $format, with disabled alpha',
          () => expect(colorFromHex(format, enableAlpha: false), expectedColor),
        );
      }

      for (var format in valid6digits) {
        final upperCaseFormat = format.toUpperCase();
        test(
          'It should accept text input with a format: $upperCaseFormat, with disabled alpha',
          () => expect(colorFromHex(upperCaseFormat, enableAlpha: false), expectedColor),
        );
      }

      for (var format in valid6digits) {
        final lowerCaseFormat = format.toLowerCase();
        test(
          'It should accept text input with a format: $lowerCaseFormat, with disabled alpha',
          () => expect(colorFromHex(lowerCaseFormat, enableAlpha: false), expectedColor),
        );
      }

      for (var format in valid6digits) {
        test(
          'It should accept text input with a format: $format',
          () => expect(colorFromHex(format), expectedColor),
        );
      }

      for (var format in valid6digits) {
        final upperCaseFormat = format.toUpperCase();
        test(
          'It should accept text input with a format: $upperCaseFormat',
          () => expect(colorFromHex(upperCaseFormat), expectedColor),
        );
      }

      for (var format in valid6digits) {
        final lowerCaseFormat = format.toLowerCase();
        test(
          'It should accept text input with a format: $lowerCaseFormat',
          () => expect(colorFromHex(lowerCaseFormat), expectedColor),
        );
      }

      for (var format in valid8digits) {
        test(
          'It should accept text input with a format: $format, with disabled alpha',
          () => expect(colorFromHex(format, enableAlpha: false), expectedColor),
        );
      }

      for (var format in valid8digits) {
        final upperCaseFormat = format.toUpperCase();
        test(
          'It should accept text input with a format: $upperCaseFormat, with disabled alpha',
          () => expect(colorFromHex(upperCaseFormat, enableAlpha: false), expectedColor),
        );
      }

      for (var format in valid8digits) {
        final lowerCaseFormat = format.toLowerCase();
        test(
          'It should accept text input with a format: $lowerCaseFormat, with disabled alpha',
          () => expect(colorFromHex(lowerCaseFormat, enableAlpha: false), expectedColor),
        );
      }

      for (var format in valid8digits) {
        test(
          'It should accept text input with a format: $format',
          () => expect(colorFromHex(format), expectedColorTransparent),
        );
      }

      for (var format in valid8digits) {
        final upperCaseFormat = format.toUpperCase();
        test(
          'It should accept text input with a format: $upperCaseFormat',
          () => expect(colorFromHex(upperCaseFormat), expectedColorTransparent),
        );
      }

      for (var format in valid8digits) {
        final lowerCaseFormat = format.toLowerCase();
        test(
          'It should accept text input with a format: $lowerCaseFormat',
          () => expect(colorFromHex(lowerCaseFormat), expectedColorTransparent),
        );
      }
    });

    group('Invalid formats test:', () {
      const Set<String> invalidFormats = {
        // x char.
        'aaBBcx',
        '#aaBBcx',
        '00aaBBcx',
        '#00aaBBcx',
        // á char.
        'áaBBcc',
        '#áaBBcc',
        '00áaBBcc',
        '#00áaBBcc',
        // cyrillic а char.
        'аaBBcc',
        '#аaBBcc',
        '00аaBBcc',
        '#00аaBBcc',
      };
      test(
        'It should return null if text length is not 3, 6 or 8',
        () {
          final StringBuffer buffer = StringBuffer();
          for (int i = 0; i <= 9; i++) {
            buffer.write(i.toString());
            expect(colorFromHex(buffer.toString()), (i == 7 || i == 5 || i == 2) ? isNot(null) : null);
          }
        },
      );

      test(
        'It should return null if text length is not 3, 6 or 8, with alpha disabled',
        () {
          final StringBuffer buffer = StringBuffer();
          for (int i = 0; i <= 9; i++) {
            buffer.write(i.toString());
            expect(
                colorFromHex(buffer.toString(), enableAlpha: false), (i == 7 || i == 5 || i == 2) ? isNot(null) : null);
          }
        },
      );

      for (var format in invalidFormats) {
        final lowerCaseFormat = format.toLowerCase();
        test(
          'It should return null if format is: $lowerCaseFormat',
          () => expect(colorFromHex(lowerCaseFormat), null),
        );
      }

      for (var format in invalidFormats) {
        final upperCaseFormat = format.toUpperCase();
        test(
          'It should return null if format is: $upperCaseFormat',
          () => expect(colorFromHex(upperCaseFormat), null),
        );
      }

      for (var format in invalidFormats) {
        test(
          'It should return null if format is: $format',
          () => expect(colorFromHex(format), null),
        );
      }

      for (var format in invalidFormats) {
        final lowerCaseFormat = format.toLowerCase();
        test(
          'It should return null if format is: $lowerCaseFormat, with alpha disabled',
          () => expect(colorFromHex(lowerCaseFormat, enableAlpha: false), null),
        );
      }

      for (var format in invalidFormats) {
        final upperCaseFormat = format.toUpperCase();
        test(
          'It should return null if format is: $upperCaseFormat, with alpha disabled',
          () => expect(colorFromHex(upperCaseFormat, enableAlpha: false), null),
        );
      }

      for (var format in invalidFormats) {
        test(
          'It should return null if format is: $format, with alpha disabled',
          () => expect(colorFromHex(format, enableAlpha: false), null),
        );
      }
    });
  });

  group('Test colorToHex:', () {
    final Map<Color, String> colorsMap = {
      const Color(0xffffffff): 'FFFFFF',
      const Color(0x00000000): '000000',
      const Color(0xF0F0F0F0): 'F0F0F0'
    };

    colorsMap.forEach((color, string) {
      final String transparency = string.substring(4);
      test(
        'It should convert $color: to ${transparency + string}',
        () => expect(colorToHex(color), transparency + string),
      );
    });

    colorsMap.forEach((color, string) {
      final String transparency = string.substring(4);
      test(
        'It should convert $color: to #${transparency + string} with hash',
        () => expect(colorToHex(color, includeHashSign: true), '#$transparency$string'),
      );
    });

    colorsMap.forEach((color, string) {
      final String transparency = string.substring(4).toLowerCase();
      test(
        'It should convert $color: to #${transparency + string.toLowerCase()}, with hash, to lower case',
        () => expect(
            colorToHex(color, includeHashSign: true, toUpperCase: false), '#$transparency${string.toLowerCase()}'),
      );
    });

    colorsMap.forEach((color, string) {
      final String transparency = string.substring(4).toLowerCase();
      test(
        'It should convert $color to ${transparency + string.toLowerCase()}, with lower case',
        () => expect(colorToHex(color, toUpperCase: false), transparency + string.toLowerCase()),
      );
    });

    colorsMap.forEach((color, string) => test(
          'It should convert $color: to $string, with alpha disabled',
          () => expect(colorToHex(color, enableAlpha: false), string),
        ));

    colorsMap.forEach((color, string) => test(
          'It should convert $color: to #$string, with alpha disabled and hash',
          () => expect(colorToHex(color, enableAlpha: false, includeHashSign: true), '#$string'),
        ));

    colorsMap.forEach((color, string) => test(
          'It should convert $color: to #${string.toLowerCase()}, with alpha disabled and hash, to lower case',
          () => expect(colorToHex(color, enableAlpha: false, includeHashSign: true, toUpperCase: false),
              '#$string'.toLowerCase()),
        ));

    colorsMap.forEach((color, string) => test(
          'It should convert $color to ${string.toLowerCase()}, with alpha disabled, to lower case',
          () => expect(colorToHex(color, enableAlpha: false, toUpperCase: false), string.toLowerCase()),
        ));
  });

  group('Test ColorExtension2.toHexString:', () {
    final Map<Color, String> colorsMap = {
      const Color(0xffffffff): 'FFFFFF',
      const Color(0x00000000): '000000',
      const Color(0xF0F0F0F0): 'F0F0F0'
    };

    colorsMap.forEach((color, string) {
      final String transparency = string.substring(4);
      test(
        'It should convert $color: to ${transparency + string}',
        () => expect(color.toHexString(), transparency + string),
      );
    });

    colorsMap.forEach((color, string) {
      final String transparency = string.substring(4);
      test(
        'It should convert $color: to #${transparency + string} with hash',
        () => expect(
            color.toHexString(includeHashSign: true), '#$transparency$string'),
      );
    });

    colorsMap.forEach((color, string) {
      final String transparency = string.substring(4).toLowerCase();
      test(
        'It should convert $color: to #${transparency + string.toLowerCase()}, with hash, to lower case',
        () => expect(
            color.toHexString(includeHashSign: true, toUpperCase: false),
            '#$transparency${string.toLowerCase()}'),
      );
    });

    colorsMap.forEach((color, string) {
      final String transparency = string.substring(4).toLowerCase();
      test(
        'It should convert $color to ${transparency + string.toLowerCase()}, with lower case',
        () => expect(
          color.toHexString(toUpperCase: false),
          transparency + string.toLowerCase(),
        ),
      );
    });

    colorsMap.forEach((color, string) => test(
          'It should convert $color: to $string, with alpha disabled',
          () => expect(
            color.toHexString(enableAlpha: false),
            string,
          ),
        ));

    colorsMap.forEach((color, string) => test(
          'It should convert $color: to #$string, with alpha disabled and hash',
          () => expect(
              color.toHexString(enableAlpha: false, includeHashSign: true),
              '#$string'),
        ));

    colorsMap.forEach((color, string) => test(
          'It should convert $color: to #${string.toLowerCase()}, with alpha disabled and hash, to lower case',
          () => expect(
            color.toHexString(
              enableAlpha: false,
              includeHashSign: true,
              toUpperCase: false,
            ),
            '#$string'.toLowerCase(),
          ),
        ));

    colorsMap.forEach((color, string) => test(
          'It should convert $color to ${string.toLowerCase()}, with alpha disabled, to lower case',
          () => expect(
              color.toHexString(enableAlpha: false, toUpperCase: false),
              string.toLowerCase()),
        ));
  });
}

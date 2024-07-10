import 'package:flutter/material.dart';
import 'package:seesights/text_field_theme.dart';
import 'package:seesights/text_theme.dart';

import 'navigationPages/elevated_theme.dart';
import 'navigationPages/outlined_button.dart';

class TAppTheme{
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    outlinedButtonTheme: TOutlinedButton.lightOutlinedButton,
    elevatedButtonTheme: TElevatedButton.LighElevatedButton,
      inputDecorationTheme: TTextFieldTheme.lightInputDecorationTheme,

  );
  static ThemeData darkTheme = ThemeData(
   /*primarySwatch: Colors.yellow,
   brightness: Brightness.dark,
   textTheme: TTextTheme.darkTextTheme,
    appBarTheme: AppBarTheme(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),*/
    
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    outlinedButtonTheme: TOutlinedButton.darkOutlinedButton,
    elevatedButtonTheme: TElevatedButton.DarkElevatedButton,
    inputDecorationTheme: TTextFieldTheme.darkInputDecorationTheme,
  );
}
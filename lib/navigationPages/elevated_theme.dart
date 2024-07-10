import 'package:flutter/material.dart';
import 'package:seesights/color.dart';
import 'package:seesights/sizes.dart';

class TElevatedButton{
  TElevatedButton. _();
  static final LighElevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: tWhiteColor,
        backgroundColor:tSecondaryColor,
        side: BorderSide(color: tSecondaryColor),
      padding: EdgeInsets.symmetric(vertical: ButtonHeight),
     shape : RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),

    ),
  );

  static final DarkElevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: tSecondaryColor,
      backgroundColor:tWhiteColor,
      side: BorderSide(color: tSecondaryColor),
      padding: EdgeInsets.symmetric(vertical: ButtonHeight),
      shape : RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      //
    ),
  );

}
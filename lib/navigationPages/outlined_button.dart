import 'package:flutter/material.dart';
import 'package:seesights/color.dart';
import 'package:seesights/sizes.dart';


class TOutlinedButton{
  TOutlinedButton. _();

  static final lightOutlinedButton = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: tSecondaryColor,
      side: BorderSide(color: tSecondaryColor),
      padding: EdgeInsets.symmetric(vertical: ButtonHeight),
    ),
  );
//
  static final darkOutlinedButton = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: tWhiteColor,
      side: BorderSide(color: tWhiteColor),
      padding: EdgeInsets.symmetric(vertical: ButtonHeight),
    ),
  );
}
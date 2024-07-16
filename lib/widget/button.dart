import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seesights/widget/app_text.dart';
import '../colors.dart';

class ResponsiveButton extends StatelessWidget {
  final bool? isResponsive;
  final double? width;

  ResponsiveButton({super.key, this.width = 110, this.isResponsive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isResponsive == true ? double.maxFinite : width,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Appcolors.maincolor,
      ),
      child: Row(
        mainAxisAlignment:
        isResponsive == true ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
        children: [
          isResponsive == true
              ? Container(
            margin: const EdgeInsets.only(left: 20),
            child: AppText(
              text: "Book Trip Now",
              color: Colors.white,
            ),
          )
              : Container(),
          Image.asset("assets/images/button1.png"),
        ],
      ),
    );
  }
}

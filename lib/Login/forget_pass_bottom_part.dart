
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seesights/Login/bottom_sheet_button.dart';
import 'package:seesights/Login/forget_pass_email_screen.dart';
import 'package:seesights/Login/forget_pass_phone_screen.dart';
import 'package:seesights/sizes.dart';
import 'package:seesights/text_strings.dart';


class ForgetPassScreen{
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context){
    return showModalBottomSheet(
        context: context, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        builder: (context) => Container(
          padding: const EdgeInsets.all(DefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tForgetPasswordTitle ,
              style: Theme.of(context).textTheme.displayMedium),
              Text(tForgetPasswordSubTitle ,
              style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 25.0),
              ForgetPassButton(
                 onTap: () {
                   Navigator.pop(context);
                   Get.to(() => const ForgetPassEmailScreen());
                 },
                title: tEmail,
                subTitle: tResetViaEMail,
                buttonIcon: Icons.mail_outline_rounded,
              ),
              const SizedBox(height: 30.0),
              ForgetPassButton(
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() => const ForgetPassPhoneScreen());
                  },
                title: tPhoneNo,
                subTitle: tResetViaPhone,
                buttonIcon: Icons.mobile_friendly_rounded,
              )
            ],
          ),
        ),
    );
    
  }
}
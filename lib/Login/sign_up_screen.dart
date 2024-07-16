import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seesights/Login/signup_controller.dart';
import 'package:seesights/Login/signup_footer_widget.dart';
import 'package:seesights/Login/signup_form_widget.dart';
import 'package:seesights/Login/signup_header.dart';
import 'package:seesights/image_strings.dart';

import 'package:seesights/sizes.dart';
import 'package:seesights/text_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(DefaultSize),
            child: Column(
              children: const [
                FormHeader(
                  image: SignUpScreenImage,
                  title: tSignUpTitle,
                  subTitle: tSignUpSubTitle,
                  imageHeight: 0.15,
                ),
                SignUpFormWidget(),
                SizedBox(height: 20),
                SignUpFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
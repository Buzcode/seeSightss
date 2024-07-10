import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seesights/Login/signup_header.dart';
import 'package:seesights/image_strings.dart';
import 'package:seesights/sizes.dart';
import 'package:seesights/text_strings.dart';


class ForgetPassPhoneScreen extends StatelessWidget {
  const ForgetPassPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(DefaultSize),
            child: Column(
              children: [
                const SizedBox(height: DefaultSize * 4),
                FormHeader(
                  image: PhonePage,
                  title: tForgetPasswordTitle.toUpperCase(),
                  subTitle: tForgetPasswordSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 25.0,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: formHeight),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text(tPhoneNo),
                          hintText: tPhoneNo,
                          prefixIcon: Icon(Icons.numbers),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(

                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(tNext),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

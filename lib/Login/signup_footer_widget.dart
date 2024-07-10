import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seesights/Login/sign_in.dart';
import 'package:seesights/image_strings.dart';
import 'package:seesights/text_strings.dart';


class SignUpFooter extends StatelessWidget {
  const SignUpFooter({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              onPressed: () {}, 
              icon: const Image(
                  image: AssetImage(GoogleLogo),
                width: 15,
              ), 
              label: Text(tSignInWithGoogle.toUpperCase()),
          ),
        ),
        TextButton(
          onPressed: () => Get.to(() => const SignIn()),
            child: Text.rich(TextSpan(children:[
             TextSpan(
               text: tAlreadyHaveAnAccount,
               style: Theme.of(context).textTheme.bodyLarge,
             ),
              TextSpan(text: tLogin.toUpperCase())
            ])),
        )
      ],
    );
  }
}

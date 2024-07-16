import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seesights/Login/sign_up_screen.dart';
import 'package:seesights/image_strings.dart';
import 'package:seesights/sizes.dart';
import 'package:seesights/text_strings.dart';


class LoginFooter extends StatelessWidget {
  const LoginFooter({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: formHeight - 20),
        SizedBox(
         width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Image(image: AssetImage(GoogleLogo) , width:20.0 ),
            onPressed: () {},
            label: const Text(tSignInWithGoogle),
          ),
        ),
        const SizedBox(height: formHeight - 15),
        TextButton(
          onPressed: () => Get.to(() => const SignUpScreen()),
            child: Text.rich(
              TextSpan(
                text: tDontHaveAnAccount,
                style: Theme.of(context).textTheme.bodyLarge,
                children: const[
                  TextSpan(text: tSignup, style: TextStyle(color:Colors.black))
                ]),
            ),
        ),
      ],
    );
  }
}

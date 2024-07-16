import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seesights/Login/sign_in.dart';
import 'package:seesights/Login/sign_up_screen.dart';
import 'package:seesights/color.dart';
import 'package:seesights/image_strings.dart';
import 'package:seesights/sizes.dart';
import 'package:seesights/text_strings.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key?key}) : super(key:key);

  @override
  Widget build(BuildContext context) {

    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? tSecondaryColor: tOnBoardingPage1Color,
      body: Container(
        padding: const EdgeInsets.all(DefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: const AssetImage(welcomeScreenImage), height: height*0.6),
            Column(
              children: [
                Text(tWelcomeTitle , style: Theme.of(context).textTheme.displaySmall),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.to(() => const SignIn()),
                      child: Text(tLogin.toUpperCase()),
                    ),
                ),
                const SizedBox(width: 10.0 ),
                Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => const SignUpScreen()),
                      child: Text(tSignup.toUpperCase()),

                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

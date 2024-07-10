import 'package:flutter/material.dart';
import 'package:seesights/image_strings.dart';
import 'package:seesights/text_strings.dart';


class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            image: const AssetImage(LoginScreen),
            height: size.height*0.3),
        Text(tLoginTitle , style: Theme.of(context).textTheme.displayLarge),

      ],
    );
  }
}

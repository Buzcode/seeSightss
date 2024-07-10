import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seesights/Login/login_form.dart';
import 'package:seesights/Login/login_header.dart';
import 'package:seesights/sizes.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(DefaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  LoginHeader(),
                  LoginForm(),
                  //LoginFooter(),
                ],
              ),
            ),
          ),
        )
    );
  }
}



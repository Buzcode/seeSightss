import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seesights/Login/signup_controller.dart';
import 'package:seesights/sizes.dart';
import 'package:seesights/text_strings.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: formHeight - 10),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.fullName, // Binding TextEditingController
              decoration: const InputDecoration(
                  label: Text(tFullName),
                  prefixIcon: Icon(Icons.person_outline_rounded)
              ),
            ),
            const SizedBox(height: formHeight - 20),
            TextFormField(
              controller: controller.email, // Binding TextEditingController
              decoration: const InputDecoration(
                  label: Text(tEmail) , prefixIcon: Icon(Icons.email_outlined)
              ),
            ),
            const SizedBox(height: formHeight - 20),
            TextFormField(
              controller: controller.phoneNo, // Binding TextEditingController
              decoration: const InputDecoration(
                label: Text(tPhoneNo) , prefixIcon: Icon(Icons.numbers),
              ),
            ),
            const SizedBox(height: formHeight - 20),
            TextFormField(
              controller: controller.password, // Binding TextEditingController
              decoration: const InputDecoration(
                  label: Text(tPassword) , prefixIcon: Icon(Icons.fingerprint)
              ),
            ),
            const SizedBox(height: formHeight - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    SignupController.instance.registerUser(
                      controller.email.text.trim(),
                      controller.password.text.trim(),
                      controller.fullName.text.trim(),
                    );
                  }
                },
                child: Text(tSignup.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
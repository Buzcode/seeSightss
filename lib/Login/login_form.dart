import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seesights/Login/forget_pass_bottom_part.dart';
import 'package:seesights/pages/home_screen.dart';
import 'package:seesights/text_strings.dart';
import '../sizes.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true; // Initially, password is hidden

  Future<void> _signInWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // Navigate to HomeScreen after successful login
        Get.to(HomeScreen());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // User not found, display error message
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No user found with that email.'))
          );
        } else if (e.code == 'wrong-password') {
          // Wrong password, display error message
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Wrong password provided.'))
          );
        } else {
          // Handle other errors
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('An error occurred. Please try again.'))
          );
        }
      } catch (e) {
        // Handle other exceptions
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('An error occurred. Please try again.'))
        );
      }
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: formHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: tEmail,
                  hintText: tEmail,
                  border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: formHeight - 15),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                labelText: tPassword,
                hintText: tPassword,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: Icon(_obscureText
                      ? Icons.remove_red_eye_sharp
                      : Icons.visibility_off_sharp),
                ),
              ),
              obscureText: _obscureText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: formHeight - 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    ForgetPassScreen.buildShowModalBottomSheet(context);
                  },
                  child: const Text(tForgetPassword)),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _signInWithEmailAndPassword,
                child: Text(tLogin.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
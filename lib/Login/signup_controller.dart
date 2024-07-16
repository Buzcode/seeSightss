import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:seesights/pages/authentication_repository.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController(); // Add this if you're collecting full name
  final phoneNo = TextEditingController(); // Add this if you're collecting phone number

  void registerUser(String email, String password) {
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }
}
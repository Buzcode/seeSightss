
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:seesights/pages/authentication_repository.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final authRepo = Get.find<AuthenticationRepository>();

  get error => null;

  void registerUser(String email, String password, String fullName) {
    authRepo.createUserWithEmailAndPassword(email, password, fullName);
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }
}
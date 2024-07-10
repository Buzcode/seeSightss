
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:seesights/pages/auth.dart';


class SignupController extends GetxController{
  static SignupController get instance=> Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  void registerUser(String email, String password){
    Auth.instance.createUserWithEmailAndPassword(email, password);
  }
}
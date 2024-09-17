import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:seesights/Models/user_model.dart';
import 'package:seesights/Models/user_repository.dart';
import 'package:seesights/pages/authentication_repository.dart';
import 'package:seesights/pages/home_screen.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController(); // Add this if you're collecting full name
  final phoneNo = TextEditingController();
  
  final userRepo = Get.put(UserRepository());

  get error => null;

   // Add this if you're collecting phone number

  void registerUser(String email, String password) {
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password) as String?;
    if(error!= null){
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }

  void createUser(UserModel user)async{
    await userRepo.createUser(user);
    Get.to(() =>  HomeScreen());
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:seesights/pages/home_screen.dart';

import '../Login/signup_email_password_failure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream((_auth.userChanges()));
  }

  Future<void> createUserWithEmailAndPassword(String email,
      String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Navigate to HomeScreen AFTER user is successfully created
      // and you've received a valid user object.
      User? user = _auth.currentUser;
      if (user != null) {
        Get.offAll(() => HomeScreen());
      } else {
        print("User creation successful, but user object is null");
        // Consider displaying an error message to the user.
      }
    } on FirebaseAuthException catch (e) {
      final ex = SignupEmailPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      // Rethrow the exception for higher level handling if needed.
      rethrow; // OR handle the exception here if you don't want to rethrow.
    } catch (_) {
      const ex = SignupEmailPasswordFailure();
      print('=EXCEPTION - ${ex.message}');
      // Rethrow the exception for higher level handling if needed.
      rethrow; // OR handle the exception here if you don't want to rethrow.
    }
  }

  // This function is NOT being used in the current implementation,
  // but it's here for demonstration purposes:
  //  You can use this if you need asynchronous navigation.
  Future<void> _navigateToHomeScreenAfterSignup() async {
    try {
      firebaseUser.stream.listen((user) {
        if (user != null) {
          Get.offAll(() => HomeScreen());
        }
      });
    } catch (e) {
      print('Error navigating to HomeScreen: ${e.toString()}');
    }
  }

  Future<void> loginWithEmailAndPassword(String email,
      String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (_) {}
  }

  Future<void> logout() async => await _auth.signOut();
}
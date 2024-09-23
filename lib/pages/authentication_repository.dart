import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seesights/pages/home_screen.dart';
import '../Login/signup_email_password_failure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream((_auth.userChanges()));
  }

  Future<void> createUserWithEmailAndPassword(String email,
      String password, String fullName) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Store user details in Firestore
      await _firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({
        'fullName': fullName,
        'email': email,

      });

      Get.offAll(() => HomeScreen());

    } on FirebaseAuthException catch (e) {
      final ex = SignupEmailPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');

      rethrow;
    } catch (_) {
      const ex = SignupEmailPasswordFailure();
      print('=EXCEPTION - ${ex.message}');

      rethrow;
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword(String email,
      String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.offAll(() => HomeScreen());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Error signing in: ${e.code}');

      rethrow;
    }
  }

  Future<void> logout() async => await _auth.signOut();
}
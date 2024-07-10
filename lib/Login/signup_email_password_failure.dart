class SignupEmailPasswordFailure{
  final String message;

  const SignupEmailPasswordFailure([this.message ="An Unknown error occurred."]);

  factory SignupEmailPasswordFailure.code(String code){
    switch(code){
      case 'weak-password':
        return const SignupEmailPasswordFailure('Please enter a stronger password.');
      case 'invalid-email':
        return const SignupEmailPasswordFailure('Email is not valid!');
      case 'email-already-in-use':
        return const SignupEmailPasswordFailure('An account already exists for that email.');
      case 'user-disabled':
        return const SignupEmailPasswordFailure('This user has been disabled.');
      default:
        return const SignupEmailPasswordFailure();
    }
  }
}
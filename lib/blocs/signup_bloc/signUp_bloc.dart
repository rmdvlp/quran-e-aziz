
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_aziz/blocs/signup_bloc/signUp_events.dart';
import 'package:quran_aziz/blocs/signup_bloc/signUp_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState>{
  SignUpBloc() : super(SignUpInitial()){
    on<SignUpButtonPressed>(_onSignUpButtonPressed);
  }
  Future<void> _onSignUpButtonPressed(
      SignUpButtonPressed event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('seenIntro', true);
      // Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: event.email, password: event.password);

      prefs.setString("email", event.email);
      prefs.setString("password", event.password);

      print("User logged in: ${userCredential.user?.email}");
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      print("Firebase exception: ${e.code}");
      emit(SignUpFailure(_firebaseErrorMessage(e)));
    } catch (e) {
      emit(SignUpFailure("Something went wrong: $e"));
    }
  }

  Future<void> _registration({
    required String email,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenIntro', true);

    try {
      // Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Store email and password in SharedPreferences
      prefs.setString("email", email);
      prefs.setString("password", password);

      print("User logged in: ${userCredential.user?.email}");
    } on FirebaseAuthException catch (e) {
      print("Firebase exception: ${e.code}");
      throw Exception(_firebaseErrorMessage(e));

    } catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }

  // Helper function for custom Firebase error messages
  String _firebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'wrong-password':
        return "Incorrect password.";
      case 'invalid-credential':
        return "Invalid email or password.";
      case 'network-request-failed':
        return "Network error. Please try again.";
      default:
        return "Unexpected error: ${e.code}";
    }
  }
}



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_event.dart';
import 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    // Registering event handler for LoginButtonPressed
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }
  // Handler for LoginButtonPressed event
  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('seenIntro', true);
      // Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: event.email, password: event.password);

      prefs.setString("email", event.email);
      prefs.setString("password", event.password);

      print("User logged in: ${userCredential.user?.email}");
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      print("Firebase exception: ${e.code}");
      emit(LoginFailure(_firebaseErrorMessage(e)));
    } catch (e) {
      emit(LoginFailure("Something went wrong: $e"));
    }
  }


  // Firebase login and local storage logic
  Future<void> _registration({
    required String email,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenIntro', true);

    try {
      // Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

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

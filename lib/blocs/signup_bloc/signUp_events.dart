class SignUpEvent{}

class SignUpButtonPressed extends SignUpEvent{
  final String email;
  final String password;
  SignUpButtonPressed(this.email, this.password);
}



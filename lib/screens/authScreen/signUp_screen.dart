import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:quran_aziz/blocs/signup_bloc/signUp_bloc.dart';
import 'package:quran_aziz/blocs/signup_bloc/signUp_events.dart';
import 'package:quran_aziz/blocs/signup_bloc/signUp_states.dart';
import 'package:quran_aziz/screens/authScreen/login_screen.dart';
import 'package:string_validator/string_validator.dart';

import '../../utils/apptheme.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../widgets/loader.dart';
import '../../widgets/textField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordObscured = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    // Get screen height and width
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer(
      bloc: BlocProvider.of<SignUpBloc>(context),
      listener: (context, state) {
        if (state is SignUpLoading) {
          const Loader();
        } else if (state is SignUpFailure) {
          FocusScope.of(context).unfocus();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            showCloseIcon: true,
            content: Text(state.error),
          ));
        } else if (state is SignUpSuccess) {
          _moveToNext();
        }
      },
      builder: (context, state) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: _body(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ));
      },
    );




  }
    _body({
      double? screenHeight,
      double? screenWidth,
    }){
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth! * 0.05), // Responsive margin
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Container(),
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Container(
                    width: screenWidth > 800 ? screenWidth * 0.4: null,

                    decoration: BoxDecoration(
                      color: AppColors.mainAppColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -(screenHeight! * 0.08), // Responsive image positioning
                          left: 0,
                          right: 0,
                          child: Center(
                            child: ClipOval(
                              child: Image(
                                height: screenHeight * 0.15, // Responsive image size
                                image: AssetImage(Images.loginImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.09),
                          child: Column(
                            children: [

                              Container(

                                margin: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.002,

                                  horizontal: screenWidth * 0.1,
                                ),
                                child: MyTextField(
                                  hintText: "Email*",
                                  controller: _emailController,
                                  onChanged: (var value) {
                                    email = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field should not be empty';
                                    } else if (!isEmail(value)) {
                                      return 'Format Should be email';
                                    }
                                    return null;
                                  },
                                  label: "Email",
                                  contentPadding: const EdgeInsets.only(top: 15),
                                  fontAwesomeIcon: FontAwesomeIcons.envelopeCircleCheck,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.002,

                                  horizontal: screenWidth * 0.1,
                                ),
                                child: MyTextField(

                                  hintText: "Password",
                                  controller: _passController,
                                  onChanged: (var value) {
                                    password = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field should not be empty';
                                    }
                                    return null;
                                  },
                                  label: "Password",
                                  obscureText: _isPasswordObscured,
                                  contentPadding: const EdgeInsets.only(top: 15),
                                  fontAwesomeIcon: _isPasswordObscured
                                      ? FontAwesomeIcons.eyeLowVision
                                      : FontAwesomeIcons.eye,
                                  onTap: () {
                                    setState(() {
                                      _isPasswordObscured = !_isPasswordObscured; // Toggle password visibility
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.03),
                              ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: WidgetStatePropertyAll(Size(  screenWidth > 800 ? screenWidth * 0.1: screenWidth * 0.5, 50)), // Responsive button width
                                  elevation: const WidgetStatePropertyAll(15),
                                ),
                                onPressed: () {
                                  if(_formKey.currentState!.validate()){
                                    email =_emailController.text;
                                    password = _passController.text;
                                    BlocProvider.of<SignUpBloc>(context).add(
                                      SignUpButtonPressed(
                                        _emailController.text,
                                        _passController.text,
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  "Sign Up",
                                  style: AppTheme.textTheme.labelLarge,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Sign In with",
                              style: AppTheme.textTheme.bodySmall,
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          FlutterSocialButton(
                            mini: true,
                            onTap: () {},
                            buttonType: ButtonType.google,
                            iconColor: Colors.black,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                          text: TextSpan(
                            text: "Already have an account?  ",
                            style: TextStyle(color: AppColors.mainAppColor, fontSize: 13),
                            children: [
                              TextSpan(
                                text: 'Log In',
                                style: AppTheme.textTheme.bodySmall!.copyWith(color: AppColors.blueTextColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _moveToNext,
                              ),
                            ],
                          )

                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    }


  _moveToNext(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen(email: email,password: password,)));
  }
}

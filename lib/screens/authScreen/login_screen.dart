// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_social_button/flutter_social_button.dart';
// import 'package:quran_aziz/screens/home_screen.dart';
// import 'package:quran_aziz/utils/apptheme.dart';
// import 'package:quran_aziz/utils/colors.dart';
// import 'package:string_validator/string_validator.dart';
//
// import '../utils/images.dart';
// import '../widgets/navBar.dart';
// import '../widgets/textField.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passController = TextEditingController();
//
//   String? email;
//   String? password;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Container(
//         margin: EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//
//           children: [
//             Expanded(
//               flex:1,
//               child: Center(
//                 child: Container(
//
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 3,
//               child: Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: AppColors.mainAppColor,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       Positioned(
//                         top: -75, // Half of the image height (150/2)
//                         left: 0,
//                         right: 0,
//                         child: Center(
//                           child: ClipOval(
//                             child: Image(
//                               height: 150,
//                               image: AssetImage(Images.loginImage),
//                               fit: BoxFit.cover, // This ensures the image covers the oval shape
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 90.0), // Adjust padding to ensure content starts below the image
//                         child: Column(
//                           children: [
//                             Container(
//                               margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
//                               child: MyTextField(
//                                 hintText: "Email*",
//                                 controller: _emailController,
//                                 onChanged: (var value) {
//                                   email = value;
//                                 },
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Field should not be empty';
//                                   } else if (!isEmail(value)) {
//                                     return 'Format Should be email';
//                                   }
//                                   return null;
//                                 },
//                                 label: "Email",
//                                 contentPadding: const EdgeInsets.only(top: 15),
//                                 fontAwesomeIcon: FontAwesomeIcons.envelopeCircleCheck,
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
//                               child: MyTextField(
//                                 hintText: "Password",
//                                 controller: _passController,
//                                 onChanged: (var value) {
//                                   password = value;
//                                 },
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Field should not be empty';
//                                   }
//                                   return null;
//                                 },
//                                 label: "Password",
//                                 contentPadding: const EdgeInsets.only(top: 15),
//                                 fontAwesomeIcon: FontAwesomeIcons.eyeLowVision,
//                               ),
//                             ),
//                             SizedBox(height: 20),
//                             Expanded(
//                               child: ElevatedButton(
//                                 style: const ButtonStyle(
//                                   fixedSize: MaterialStatePropertyAll(Size.fromWidth(150)),
//                                   elevation: MaterialStatePropertyAll(15),
//
//                                 ),
//                                 onPressed: () {
//                                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyNavBar()));
//                                 },
//                                 child: Text("Login",style: AppTheme.textTheme.labelLarge,),
//                               ),
//                             ),
//                             SizedBox(height: 20),
//
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             Expanded(
//              flex: 2,
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     // Text("Forgot Password"),
//                     // Text("Dont Have An Account"),
//                     Row(
//                       children: [
//                         // Left line
//                         Expanded(
//                           child: Divider(
//                             color: Colors.grey, // Set the color of the line
//                             thickness: 1, // Set the thickness of the line
//                           ),
//                         ),
//
//                         // Text in the middle
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10), // Adds space between the text and the lines
//                           child: Text(
//                             "Sign In with",
//                             style: AppTheme.textTheme.bodySmall,
//                           ),
//                         ),
//
//                         // Right line
//                         Expanded(
//                           child: Divider(
//                             color: Colors.grey, // Set the color of the line
//                             thickness: 1, // Set the thickness of the line
//                           ),
//                         ),
//                       ],
//                     ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: [
//                          FlutterSocialButton(
//                            mini: true,
//                            onTap: () {},
//                            buttonType: ButtonType.facebook, // Button type for different type buttons
//                          ),
//
//                          //For google Button
//
//                          FlutterSocialButton(
//                            mini: true,
//                            onTap: () {},
//                            buttonType: ButtonType.google, // Button type for different type buttons
//                            iconColor: Colors.black,  // for change icons colors
//                          ),
//
//                          // for Mini Circle Button
//
//                          FlutterSocialButton(
//                            onTap: () {},
//                            mini: true,   //just pass true for mini circle buttons
//                            buttonType: ButtonType.phone,  // Button type for different type buttons
//                          )
//                        ],
//                      )
//
//
//
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
// }


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:quran_aziz/screens/authScreen/signUp_screen.dart';
import 'package:quran_aziz/services/auth.dart';
import 'package:quran_aziz/utils/apptheme.dart';
import 'package:quran_aziz/utils/colors.dart';
import 'package:quran_aziz/widgets/loader.dart';
import 'package:string_validator/string_validator.dart';
import '../../blocs/login_bloc/login_bloc.dart';
import '../../blocs/login_bloc/login_event.dart';
import '../../blocs/login_bloc/login_states.dart';
import '../../utils/images.dart';
import '../../widgets/navBar.dart';
import '../../widgets/textField.dart';

class LoginScreen extends StatefulWidget {
  final String? email;
  final String? password;
  const LoginScreen({super.key, this.email, this.password});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordObscured = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  String? email;
  String? password;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController(text: widget.email ?? '');
    _passController = TextEditingController(text: widget.password ?? '');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer(
      bloc: BlocProvider.of<LoginBloc>(context),
      listener: (context, state) {
        if (state is LoginLoading) {
          const Loader();
        } else if (state is LoginFailure) {
          FocusScope.of(context).unfocus();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            showCloseIcon: true,
            content: Text(state.error),
          ));
        } else if (state is LoginSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyNavBar()),
          );
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
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth! * 0.05), // Responsive margin
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
                  width: screenWidth > 800 ? screenWidth * 0.4 : null,
                  decoration: BoxDecoration(
                    color: AppColors.mainAppColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -(screenHeight! *
                            0.08), // Responsive image positioning
                        left: 0,
                        right: 0,
                        child: Center(
                          child: ClipOval(
                            child: Image(
                              height:
                                  screenHeight * 0.15, // Responsive image size
                              image: AssetImage(Images.loginImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.1),
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
                                fontAwesomeIcon:
                                    FontAwesomeIcons.envelopeCircleCheck,
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
                                obscureText: _isPasswordObscured,
                                label: "Password",
                                contentPadding: const EdgeInsets.only(top: 15),
                                fontAwesomeIcon: _isPasswordObscured
                                    ? FontAwesomeIcons.eyeLowVision
                                    : FontAwesomeIcons.eye,
                                onTap: () {
                                  setState(() {
                                    _isPasswordObscured =
                                        !_isPasswordObscured; // Toggle password visibility
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            ElevatedButton(
                              style: ButtonStyle(
                                fixedSize: WidgetStatePropertyAll(Size(
                                    screenWidth > 800
                                        ? screenWidth * 0.1
                                        : screenWidth * 0.5,
                                    50)), // Responsive button width
                                elevation: const WidgetStatePropertyAll(15),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  email = _emailController.text;
                                  password = _passController.text;
                                  BlocProvider.of<LoginBloc>(context).add(
                                    LoginButtonPressed(
                                      _emailController.text,
                                      _passController.text,
                                    ),
                                  );
                                }
                                setState(() {});
                              },
                              child: Text(
                                "Login",
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
                        // FlutterSocialButton(
                        //   mini: true,
                        //   onTap: () {},
                        //   buttonType: ButtonType.facebook,
                        // ),
                        FlutterSocialButton(
                          mini: true,
                          onTap: () {
                            AuthMethods().signInWithGoogle(context);
                          },
                          buttonType: ButtonType.google,
                          iconColor: Colors.black,
                        ),
                        // FlutterSocialButton(
                        //   onTap: () {},
                        //   mini: true,
                        //   buttonType: ButtonType.phone,
                        // ),
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
                      text: "Don't have an account?  ",
                      style: TextStyle(
                          color: AppColors.mainAppColor, fontSize: 13),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: AppTheme.textTheme.bodySmall!
                              .copyWith(color: AppColors.blueTextColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _moveToSignUp,
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _moveToSignUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }
}

// SHA1: 6C:56:97:B8:F3:61:E8:F7:67:3A:38:1F:51:59:FE:1B:A8:89:E5:E9
// SHA256: A5:FB:7C:FC:FA:27:E1:AD:A4:CF:2A:A0:06:DA:F5:E9:ED:83:07:1A:8E:7C:C4:83:94:23:75:10:3C:1A:34:C2

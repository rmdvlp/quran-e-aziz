import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/colors.dart';




class MyTextField extends StatelessWidget {
  final String? hintText;
  final String label;
  final EdgeInsetsGeometry? contentPadding;
 final  IconData? icon;
 final  IconData? icon2;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final bool autoFocus;
   final bool? enabled;
  final IconData? fontAwesomeIcon;
  void Function()? onTap;
  // String? onChangeText;f
  // String? onChangevalue;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  TextEditingController? controller;
   MyTextField({super.key,this.onTap,this.hintText,this.icon,this.controller,this.validator,this.onChanged, this.icon2,  this.obscureText=false, this.suffixIcon=const SizedBox(), this.prefixIcon, this.contentPadding, this.keyboardType, this.autoFocus=false, this.enabled=true, this.fontAwesomeIcon, this.label="",});


  @override
  Widget build(BuildContext context) {

    return TextFormField(
      enabled: enabled,
      autofocus:autoFocus,
      keyboardType: keyboardType,
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      validator: validator,

      decoration:  InputDecoration(
        enabledBorder: const UnderlineInputBorder( //<-- SEE HERE
          borderSide: BorderSide(
               color: AppColors.white),
        ),
        isDense: true,
        contentPadding:contentPadding,
        hintText: hintText,

        label: Text(label, style: const TextStyle(color: AppColors.white,fontSize: 14),),
        hintStyle: const TextStyle(color: AppColors.hintTextColor,),
        // prefix: SizedBox(width: 5,),
        prefixIcon:prefixIcon,
        suffixIcon:
          Container(
              margin:const EdgeInsets.only(top: 10,left: 20),
              child: GestureDetector(
                onTap: onTap,
                  child: FaIcon(fontAwesomeIcon,size: 22,color: AppColors.white,))),
      ),
      style: const TextStyle(fontSize: 18, color: AppColors.white),

    );
  }
}

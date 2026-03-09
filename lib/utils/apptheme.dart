import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme{
  static _border({Color color = AppColors.white}){
    return UnderlineInputBorder(borderSide: BorderSide(color: color));
  }

  static ThemeData data()=>
  ThemeData(
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: _border(),
        enabledBorder: _border(),
        errorBorder: _border(color: Colors.red),
        disabledBorder: _border(color: Colors.red),
        border: _border()

    ),
  );


   static TextTheme textTheme = TextTheme(
     labelLarge:GoogleFonts.roboto(
          fontSize: 15, fontWeight: FontWeight.w700,color: AppColors.mainAppColor),
     bodySmall: GoogleFonts.roboto(
       fontSize: 15, fontWeight: FontWeight.w400,color: AppColors.mainAppColor),
     displayLarge: GoogleFonts.roboto(
         fontSize: 30, fontWeight: FontWeight.w600,color: AppColors.mainAppColor),
     titleMedium: GoogleFonts.inter(
         fontSize: 20, fontWeight: FontWeight.w400,color: AppColors.white),
     labelSmall: GoogleFonts.roboto(
       fontSize: 13, fontWeight: FontWeight.w500,color: AppColors.white),
     // titleLarge: GoogleFonts.roboto(
     //     fontSize: 20, fontWeight: FontWeight.w500,color: AppColors.subTitle),

   );


}
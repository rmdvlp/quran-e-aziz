import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/colors.dart';


class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return   Center(child:  SpinKitChasingDots(
    color: AppColors.mainAppColor, // You can change this to your preferred color
    size: 50.0,
    ),
    );
  }
}

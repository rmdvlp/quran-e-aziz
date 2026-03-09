import 'package:flutter/material.dart';

import 'colors.dart';


class MoreScreensAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;
  final String? text;
  const MoreScreensAppBar({super.key, this.color, this.text});
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme:  IconThemeData(
        color: color, // Back button color
      ),
      centerTitle: true,
      title:  Text(text!,style: const TextStyle(color: AppColors.white),),
      backgroundColor: AppColors.mainAppColor,
    );
  }
}

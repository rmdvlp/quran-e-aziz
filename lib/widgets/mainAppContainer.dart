

import 'package:flutter/material.dart';

import '../utils/apptheme.dart';
import '../utils/colors.dart';
import '../utils/images.dart';
import '../utils/size_config.dart';

class MainAppContainer extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  final void Function()? onTap;
  const MainAppContainer({super.key, required this.title, required this.imageUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context,constraints) {
        return GestureDetector(
          onTap: onTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: screenWidth > 800 ? screenHeight * 0.3: null,
                margin:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.05, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.mainAppColor,
                  boxShadow:   [
                    BoxShadow(
                      color: AppColors.mainAppColor,
                      blurRadius: 4,
                      offset:  const Offset(1, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                    child: Text(
                      "\n$title",
                      style: AppTheme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w300),
                    )),
              ),
              screenWidth > 800 ?
              Positioned(
                // Adjust this value to set the exact position
                left: 0,
                right: 0,
                child: Center(
                  child: Material(
                    color: AppColors.mainAppColor,
                    elevation: 10.0, // Elevation effect
                    shape: const CircleBorder(),
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        height:  screenHeight * 0.17,
                        width:screenWidth * 0.1,
                        filterQuality: FilterQuality.high,
                        placeholder: Images.quranAzizImage,
                        image: imageUrl!,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return  Image(image: AssetImage(Images.quranAzizImage,),  height:  screenHeight * 0.17,
                            );
                        },
                      ),
                    ),
                  ),
                ),
              )
            : Positioned(
                bottom: sizeConfig
                    .height(0.15),

                // Adjust this value to set the exact position
                left: 0,
                right: 0,
                child: Center(
                  child: Material(
                    color: AppColors.mainAppColor,
                    elevation: 10.0, // Elevation effect
                    shape: const CircleBorder(),
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        height:   90,
                        width:  90,
                        filterQuality: FilterQuality.high,
                        placeholder: Images.quranAzizImage,
                        image: imageUrl! ,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

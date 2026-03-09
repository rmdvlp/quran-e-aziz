

import 'package:flutter/material.dart';
import 'package:quran_aziz/screens/moreScreen/bioGraphy_screen/bioGraphy_screen.dart';
import 'package:quran_aziz/screens/moreScreen/qibla_direction_screen/qiblah_direction_screen.dart';
import '../../model_classes/QuranScreenData.dart';
import '../../utils/appbar.dart';
import '../../utils/global_class.dart';
import '../../utils/images.dart';
import '../../utils/size_config.dart';
import '../../widgets/buildDrawer.dart';
import '../../widgets/drawer.dart';
import '../../widgets/mainAppContainer.dart';

class MoreInfoScreen extends StatelessWidget {
  const MoreInfoScreen({super.key});
  static  final List<QuranScreenData> _imageUrls = [
    QuranScreenData(title: "Biography", imageUrl: 'https://upload.wikimedia.org/wikipedia/en/0/06/Ahmed_Ali_Lahori.jpg',),
    // QuranScreenData(title: "Majlis Zikar", imageUrl: 'https://www.soundvision.com/sites/default/files/styles/article-teaser/public/field/image/Dua_011b.jpg?itok=Tn-c7Bfu',),
    QuranScreenData(title: "Qibla Direction", imageUrl: 'https://play-lh.googleusercontent.com/1GJCxR62N-ITd6GHYmDF_0_5FYICRAlih_DhYitoyG3zAEhqdhkYSndjYdL_7n8Rm1g',),
    QuranScreenData(title: "About Us", imageUrl: 'https://media.istockphoto.com/id/950039636/vector/about-us-flat-design-orange-round-vector-icon-in-eps-10.jpg?s=612x612&w=0&k=20&c=3eXs5SjFq4TWTIi7zoWifTn9q4xulmyB53dyuPP4ypg=',),
    // QuranScreenData(title: "About App", imageUrl: 'https://mir-s3-cdn-cf.behance.net/project_modules/disp/4757e2102779107.5f3e4b9d1f224.jpg',),
    // QuranScreenData(title: "Contact Us", imageUrl: 'https://www.citypng.com/public/uploads/preview/hd-green-round-circle-phone-icon-transparent-png-70175169505965581ekiydn5v.png'),


  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: GlobalClass.scaffoldKey,
      drawer:screenWidth > 800 ? const BuildDrawer():const MyDrawer(),
      appBar:  CustomAppBar(title: "More Info",imagepath:Images.loginImage,scaffoldKey: GlobalClass.scaffoldKey,),
      body:Container(
          margin: EdgeInsets.only(top: sizeConfig.height(0.02)),
          child: GridView.builder(
              itemCount: _imageUrls.length,
              gridDelegate:sizeConfig.deviceWidth > 800 ? const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ):
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9, // Adjust this ratio as needed
              ),
              itemBuilder: (context, index) {
                return MainAppContainer(
                  onTap: (){
                    if(_imageUrls[index].title == "Biography"){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const BioGraphy()));
                    }else  if(_imageUrls[index].title == "Majlis Zikar"){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> const QiblahDirectionScreen()));
                    }else  if(_imageUrls[index].title == "Qibla Direction"){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const QiblahDirectionScreen()));
                    }else  if(_imageUrls[index].title == "About Us"){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>  AboutUsScreen()));
                    }else  if(_imageUrls[index].title == "About App"){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> const QiblahDirectionScreen()));
                    }else  if(_imageUrls[index].title == "Contact Us"){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> const QiblahDirectionScreen()));
                    }
                  },
                  title: _imageUrls[index].title,
                  imageUrl: _imageUrls[index].imageUrl, );
              })),

    );
  }
}

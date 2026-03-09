import 'package:flutter/material.dart';
import 'package:quran_aziz/model_classes/QuranScreenData.dart';
import 'package:quran_aziz/screens/quranScreen/khatmul_quran/khatmul_quran_screen.dart';
import 'package:quran_aziz/screens/quranScreen/quran-e-aziz/quran-e-Aziz_Screen.dart';
import 'package:quran_aziz/screens/quranScreen/serat-ul-Nabi/serat-ul-nabi_Screen.dart';
import 'package:quran_aziz/utils/images.dart';
import 'package:quran_aziz/utils/size_config.dart';

import '../../utils/appbar.dart';
import '../../utils/global_class.dart';
import '../../widgets/drawer.dart';
import '../../widgets/mainAppContainer.dart';

class QuranScreen extends StatelessWidget {
   const QuranScreen({super.key});

  static  final List<QuranScreenData> _imageUrls = [
    QuranScreenData(title: "Quran-e-Aziz", imageUrl: 'https://img.freepik.com/premium-vector/muslim-boy-reading-quran-book_320705-166.jpg',),
    QuranScreenData(title: "Serat-Un-Nabi", imageUrl: 'https://images.saatchiart.com/saatchi/1710631/art/8096639/7163429-HSC00002-7.jpg',),
    // QuranScreenData(title: "Urdu Term", imageUrl: 'https://i.etsystatic.com/26910294/r/il/a9de80/3538021984/il_fullxfull.3538021984_2kme.jpg',),
    QuranScreenData(title: "Khatm-Ul-Quran", imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzIhZ2WgFHyL9NBhUoKS2kHItA_bBTfXAsyg&s',),
    // QuranScreenData(title: "Fahm-Ul-Quran", imageUrl: 'https://play-lh.googleusercontent.com/p6JqTpbsjuDqZFXXK6i_Hl87kuu04stWu0aZ29JvC8DBFVPy5WM05B6StY0J5M6OOaI',),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalClass.scaffoldKey,
      drawer: const MyDrawer(),
      appBar: CustomAppBar(
        title: "Quran",
        imagepath: Images.quranAzizImage,
        scaffoldKey: GlobalClass.scaffoldKey,

      ),
      body: Container(
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
                    print("here is index title ${_imageUrls[index].title}");
                    if(_imageUrls[index].title == "Quran-e-Aziz"){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const QuraneAziz()));
                    } else   if(_imageUrls[index].title == "Khatm-Ul-Quran"){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const KhatmulQuranScreen()));
                    }else   if(_imageUrls[index].title == "Serat-Un-Nabi"){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const SeratulNabiScreen()));
                    }
                  },
                  title: _imageUrls[index].title,
                  imageUrl: _imageUrls[index].imageUrl, );
              })


      ),
    );
  }

}



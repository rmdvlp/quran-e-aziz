import 'package:flutter/material.dart';
import 'package:quran_aziz/screens/ibadatScreen/fastingScreen/fasting_screen.dart';
import 'package:quran_aziz/screens/ibadatScreen/hajjoUmrah/hajj_o_umrah_screen.dart';
import 'package:quran_aziz/screens/ibadatScreen/nmaz-e-jnaza/nmazeJanaza_scree.dart';
import 'package:quran_aziz/screens/ibadatScreen/prayerTimingsScreen/prayer_timings_screen.dart';
import 'package:quran_aziz/screens/ibadatScreen/tasbihScreen/tasbih_screen.dart';

import '../../model_classes/QuranScreenData.dart';
import '../../utils/appbar.dart';
import '../../utils/global_class.dart';
import '../../utils/images.dart';
import '../../utils/size_config.dart';
import '../../widgets/drawer.dart';
import '../../widgets/mainAppContainer.dart';

class IbadatScreen extends StatelessWidget {
  const IbadatScreen({super.key});
  static final List<QuranScreenData> _imageUrls = [
    QuranScreenData(
      title: "Prayer",
      imageUrl:
          'https://t4.ftcdn.net/jpg/06/98/80/13/360_F_698801380_yOCD1zSRZgwuKLgEW65ZequaQJasulfU.jpg',
    ),
    QuranScreenData(
      title: "Fasting",
      imageUrl:
          'https://media.istockphoto.com/id/1304710913/vector/muslim-family-praying-before-having-iftar.jpg?s=2048x2048&w=is&k=20&c=8DvTqizFKKUudGfIGAOdQsMS9HKMOI8z-ewwZm6Vw9A=',
    ),
    QuranScreenData(
      title: "Hajj / Umrah",
      imageUrl:
          'https://media.istockphoto.com/id/1467960749/photo/muslim-pilgrims-at-the-kaaba-in-the-haram-mosque-of-mecca-saudi-arabia-in-the-morning.jpg?s=612x612&w=0&k=20&c=Zid-nGlLSwoDuBqE2syFTbTv5ed2Og_Sic03UjrxXvk=',
    ),
    QuranScreenData(
      title: "Nmaz E Janaza",
      imageUrl:
          'https://play-lh.googleusercontent.com/4KqfQdURKwFm3PTmMsrJjafN-zA532Ly9Rc6xplfnRD7KErxFtbyvkCPP6QHXgxjkw',
    ),
    QuranScreenData(
      title: "Tasbih",
      imageUrl:
          'https://quranblessing.com/wp-content/uploads/2023/12/What-is-tasbeeh-430x400.webp',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalClass.scaffoldKey,
      drawer: const MyDrawer(),
      appBar: CustomAppBar(
        title: "Ibadat",
        imagepath: Images.ibadatImage,
        scaffoldKey: GlobalClass.scaffoldKey,
      ),
      body: Container(
          margin: EdgeInsets.only(top: sizeConfig.height(0.02)),
          child: GridView.builder(
              itemCount: _imageUrls.length,
              gridDelegate: sizeConfig.deviceWidth > 800
                  ? const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    )
                  : const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9, // Adjust this ratio as needed
                    ),
              itemBuilder: (context, index) {
                return MainAppContainer(
                  onTap: () {
                    print("here is indexex?>${_imageUrls[index].title}");
                    if (_imageUrls[index].title == "Prayer") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PrayerTimingsScreen()));
                    } else if (_imageUrls[index].title == "Fasting") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FastingScreen()));
                    } else if (_imageUrls[index].title == "Hajj / Umrah") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HajjOUmrahScreen()));
                    } else if (_imageUrls[index].title == "Nmaz E Janaza") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NmazeJnazaScreen()));
                    } else if (_imageUrls[index].title == "Tasbih") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TasbihScreen()));
                    }
                  },
                  title: _imageUrls[index].title,
                  imageUrl: _imageUrls[index].imageUrl,
                );
              })),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quran_aziz/screens/hadithScreen/ahadees_screen.dart';
import 'package:quran_aziz/utils/global_class.dart';
import 'package:quran_aziz/widgets/loader.dart';
import '../../model_classes/QuranScreenData.dart';
import '../../utils/appbar.dart';
import '../../utils/images.dart';
import '../../utils/size_config.dart';
import '../../widgets/drawer.dart';
import '../../widgets/mainAppContainer.dart';

class HadithScreen extends StatefulWidget {
  const HadithScreen({super.key});
  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  static final List<QuranScreenData> _imageUrls = [];
  static bool _isDataFetched = false;

  @override
  void initState() {
    super.initState();
    if (_isDataFetched) {
      return;
    }
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalClass.scaffoldKey,
      drawer: const MyDrawer(),
      appBar: CustomAppBar(
        title: "Hadith",
        imagepath: Images.hadithImage,
        scaffoldKey: GlobalClass.scaffoldKey,
      ),
      body: Container(
          margin: EdgeInsets.only(top: sizeConfig.height(0.02)),
          child: _imageUrls.isEmpty
              ? const Loader()
              : GridView.builder(
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AhadeesScreen(
                                        titleAppBar: _imageUrls[index].title,
                                      )));
                        },
                        title: _imageUrls[index].title,
                        imageUrl: _imageUrls[index].imageUrl);
                  })),
    );
  }

  _loadData() async {
    _imageUrls.clear();
    await fetchCollections();
  }

  Future<List<QuranScreenData>> fetchCollections() async {
    var documentSnapshot = await GlobalClass.fireBaseDB
        .collection('ahadiths')
        .orderBy('timestamp')
        .get();
    for (var val in documentSnapshot.docs) {
      _imageUrls.add(
          QuranScreenData(title: val.id, imageUrl: val.data()['hadithImage']));
    }
    _isDataFetched = true;
    if (mounted) {
      setState(() {});
    }
    return _imageUrls;
  }
}

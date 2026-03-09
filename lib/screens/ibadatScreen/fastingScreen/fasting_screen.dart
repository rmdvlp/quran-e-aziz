import 'package:flutter/material.dart';
import 'package:quran_aziz/widgets/loader.dart';

import '../../../utils/colors.dart';
import '../../../utils/global_class.dart';
import '../../../utils/more_screens_appBar.dart';

class FastingScreen extends StatefulWidget {
  const FastingScreen({super.key});

  @override
  State<FastingScreen> createState() => _KhatmulQuranScreenState();
}

class _KhatmulQuranScreenState extends State<FastingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _loadData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   const MoreScreensAppBar(
        color: AppColors.white,
        text: "Fasting Dua" ,
      ),
      body: isLoading == false?const Loader():Center(child: Image.network(imageUrl,)),
    );
  }
  String imageUrl="";
  bool isLoading=false;
  _loadData()async{

    var db= await GlobalClass.fireBaseDB
        .collection('fastingDua')
        .doc('oUcKxaepnGQMHqmeCK6R')  // Or use `.get()` for retrieving a document
        .get();
    Map data= db.data()!;
    imageUrl = data['fastingDuaUrl'];
    isLoading =true;
    setState(() {});
  }
}

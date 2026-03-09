import 'package:flutter/material.dart';
import 'package:quran_aziz/widgets/loader.dart';

import '../../../utils/colors.dart';
import '../../../utils/global_class.dart';
import '../../../utils/more_screens_appBar.dart';

class KhatmulQuranScreen extends StatefulWidget {
  const KhatmulQuranScreen({super.key});

  @override
  State<KhatmulQuranScreen> createState() => _KhatmulQuranScreenState();
}

class _KhatmulQuranScreenState extends State<KhatmulQuranScreen> {
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
        text: "Dua Khatmul Quran" ,
      ),
      body: isLoading == false?const Loader():Image.network(imageUrl,height: 600,),
    );
  }
String imageUrl="";
  bool isLoading=false;
  _loadData()async{

    var db= await GlobalClass.fireBaseDB
        .collection('duaKhatmulQuran')
        .doc('dH2pcMF6R7eO70n9Ipdk')  // Or use `.get()` for retrieving a document
        .get();
    Map data= db.data()!;
   imageUrl = data['duaKhatmulQuranUrl'];
    isLoading =true;
    setState(() {});
  }
}

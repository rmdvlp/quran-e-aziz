import 'package:flutter/material.dart';
import 'package:quran_aziz/widgets/loader.dart';

import '../../../utils/colors.dart';
import '../../../utils/global_class.dart';
import '../../../utils/more_screens_appBar.dart';

class NmazeJnazaScreen extends StatefulWidget {
  const NmazeJnazaScreen({super.key});

  @override
  State<NmazeJnazaScreen> createState() => _KhatmulQuranScreenState();
}

class _KhatmulQuranScreenState extends State<NmazeJnazaScreen> {
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
        text: "Nmaz-e-Janaza" ,
      ),
      body: isLoading == false?const Loader():Center(child: Image.network(imageUrl,)),
    );
  }
  String imageUrl="";
  bool isLoading=false;
  _loadData()async{

    var db= await GlobalClass.fireBaseDB
        .collection('nmaz-e-janaza')
        .doc('POVb3J9VlrDNLRdf0FJo')  // Or use `.get()` for retrieving a document
        .get();
    Map data= db.data()!;
    imageUrl = data['nmaz-e-jnazaUrl'];
    isLoading =true;
    setState(() {});
  }
}

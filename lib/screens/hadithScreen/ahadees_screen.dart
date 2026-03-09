import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/colors.dart';
import '../../utils/global_class.dart';
import '../../utils/more_screens_appBar.dart';

class AhadeesScreen extends StatefulWidget {
  final String? titleAppBar;
  const AhadeesScreen({super.key, this.titleAppBar});

  @override
  State<AhadeesScreen> createState() => _AhadeesScreenState();
}

class _AhadeesScreenState extends State<AhadeesScreen> {
  String? localFilePath;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("title appvbat>>>>> ${widget.titleAppBar}");
    _loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   MoreScreensAppBar(
        color: AppColors.white,
        text: widget.titleAppBar,
      ),
      body:
      const Center(child: Text("No Data found")),
      // isLoading
      //     ? Loader():
      // PDFView(
      //   filePath: localFilePath,
      //   enableSwipe: true,
      //   swipeHorizontal: false,
      //   autoSpacing: false,
      //   pageFling: true,
      //   fitEachPage: true, // Ensures each page fits the screen
      //   fitPolicy: FitPolicy.BOTH,
      //
      // ),
    );
  }
  String url="";
  _loadData()async{
    if(widget.titleAppBar == "صحیح بخاری"){
      var bioGraphy= await GlobalClass.fireBaseDB
          .collection('sahiBukhari')
          .doc('whQsi9ZLDeped4HZMDZY')  // Or use `.get()` for retrieving a document
          .get();
      var imageUrl=bioGraphy.data();
      url = imageUrl?['sahiBukhariUrl'];
    } else  if(widget.titleAppBar == "صحیح مسلم"){
      var bioGraphy= await GlobalClass.fireBaseDB
          .collection('sahiMuslim')
          .doc('VyoFNGWcPGh4HQB2HXz2')  // Or use `.get()` for retrieving a document
          .get();

      var imageUrl=bioGraphy.data();
      url = imageUrl?['sahiMuslimUrl'];
    }else  if(widget.titleAppBar == "سنن ترمذی"){
      var bioGraphy= await GlobalClass.fireBaseDB
          .collection('jamiaTirmizi')
          .doc('XhFhCTyFO8FAEU3a65vl')  // Or use `.get()` for retrieving a document
          .get();

      var imageUrl=bioGraphy.data();
      url = imageUrl?['jamiaTirmiziUrl'];
    }else{

    }



    _downloadAndLoadPdf(url: url);

    setState(() {});
  }
  Future<void> _downloadAndLoadPdf({String? url}) async {
    print("url pass as a argu:   $url");

    try {
      final directory = await getApplicationDocumentsDirectory();  // Get app's local directory
      final filePath = '${directory.path}/hadith.pdf';  // File path to save the downloaded PDF
      await Dio().download(url!, filePath);  // Download the PDF

      setState(() {
        localFilePath = filePath;  // Update the file path once the PDF is downloaded
        isLoading = false;  // Stop the loader once the download is complete
      });
    } catch (e) {
      print("Error downloading PDF: $e");
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/global_class.dart';
import '../../../utils/more_screens_appBar.dart';
import '../../../widgets/loader.dart';
class SeratulNabiScreen extends StatefulWidget {
  const SeratulNabiScreen({super.key});

  @override
  State<SeratulNabiScreen> createState() => _QuraneAzizState();
}

class _QuraneAzizState extends State<SeratulNabiScreen> {
  @override
  String? localFilePath;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(downloadPdfUrl ==false){
      _loadData();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const MoreScreensAppBar(
        color: AppColors.white,
        text: "Serat-un-Nabi" ,
      ),
      body: isLoading
          ? const Loader():
      PDFView(
        filePath: localFilePath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: true,
        fitEachPage: true, // Ensures each page fits the screen
        fitPolicy: FitPolicy.BOTH,

      ),
    );
  }
  String url="";
  bool downloadPdfUrl = false;
  _loadData()async{
    var bioGraphy= await GlobalClass.fireBaseDB
        .collection('serat-ul-Nabi')
        .doc('J9reqGaAxCrPfEL0yWzn')  // Or use `.get()` for retrieving a document
        .get();
    var imageUrl=bioGraphy.data();

    url = imageUrl?['sarat-ul-NabiUrl'];
    downloadPdfUrl = true;
    setState(() {});
      _downloadAndLoadPdf(url: url);


    setState(() {});
  }
  Future<void> _downloadAndLoadPdf({String? url}) async {
    print("url pass as a argu:   $url");

    try {
      final directory = await getApplicationDocumentsDirectory();  // Get app's local directory
      final filePath = '${directory.path}/SeratulNabiScreen.pdf';  // File path to save the downloaded PDF
      await Dio().download(url!, filePath);  // Download the PDF

      setState(() {
        localFilePath = filePath;  // Update the file path once the PDF is downloaded
        isLoading = false;  // Stop the loader once the download is complete
      });
    } catch (e) {
      print("Error downloading PDF: $e");
    }
  }  }

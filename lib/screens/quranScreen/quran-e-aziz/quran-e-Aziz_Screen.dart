import 'package:flutter/material.dart';
import 'package:quran_aziz/screens/quranScreen/quran-e-aziz/add_parah_screen.dart';
import 'package:quran_aziz/screens/quranScreen/quran-e-aziz/parah-detail/parah-detail-page.dart';
import 'package:quran_aziz/utils/apptheme.dart';
import '../../../utils/colors.dart';
import '../../../utils/global_class.dart';
import '../../../utils/more_screens_appBar.dart';
import '../../../widgets/loader.dart';

class QuraneAziz extends StatefulWidget {
  const QuraneAziz({super.key});

  @override
  State<QuraneAziz> createState() => _QuraneAzizState();
}

class _QuraneAzizState extends State<QuraneAziz> {
  List<Map<String, String>> collectionList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCollections();

    // _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MoreScreensAppBar(
          color: AppColors.white,
          text: "Quran-e-Aziz",
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.mainAppColor,
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddParahScreen()),
            );

            if (result == true) {
              collectionList.clear();
              await fetchCollections();
            }
          },
          child: const Icon(Icons.add, color: AppColors.white),
        ),
        body: collectionList.isEmpty
            ? const Loader()
            : ListView.builder(
                itemCount: collectionList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      minVerticalPadding: 20,

                      tileColor: AppColors.mainAppColor,
                      shape: const StadiumBorder(),
                      title: Text(
                        collectionList[index]['name'] ?? '',
                        style: AppTheme.textTheme.labelLarge!
                            .copyWith(color: AppColors.white),
                      ),
                      // subtitle: Text("Pages length",style: AppTheme.textTheme.bodySmall!.copyWith(color: AppColors.white)),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.white,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ParahDetailScreen(
                                      documentId:
                                          collectionList[index]['id'] ?? '',
                                      parahTitle:
                                          collectionList[index]['name'] ?? '',
                                    )));
                      },
                    ),
                  );
                }));
  }

  Future<List<Map<String, String>>> fetchCollections() async {
    var documentSnapshot = await GlobalClass.fireBaseDB
        .collection('quran-e-aziz')
        .orderBy('timestamp')
        .get();
    collectionList.clear();
    for (var val in documentSnapshot.docs) {
      final data = val.data();
      collectionList.add({
        'id': val.id,
        'name': (data['name'] ?? val.id).toString(),
      });
    }
    if (mounted) {
      setState(() {});
    }
    return collectionList;
  }
}

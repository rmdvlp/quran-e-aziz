
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:quran_aziz/utils/colors.dart';
import '../utils/appbar.dart';
import '../utils/global_class.dart';
import '../utils/images.dart';
import '../utils/more_screens_appBar.dart';
import '../widgets/buildDrawer.dart';
import '../widgets/drawer.dart';
import '../widgets/loader.dart';

class MyHomePage extends StatefulWidget {
    const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _imageUrls = [];

  @override
  void initState() {
    // TODO: implement initState
    _loadData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: GlobalClass.scaffoldKey,
      drawer:screenWidth > 800 ? const BuildDrawer():const MyDrawer(),
      appBar:  CustomAppBar(title: "Home", imagepath: Images.hazratImage,scaffoldKey:GlobalClass.scaffoldKey,),
      body: Center(
        child:
        _imageUrls.isEmpty
            ? const Loader()
        :
        GridView.builder(
          itemCount: _imageUrls.length,
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:  screenWidth > 800 ?  4 : 2
            ),
            itemBuilder: (context, index) {
              return
                _homeContainer(imageUrl: _imageUrls[index], context:context, screenWidth: MediaQuery.of(context).size.width,
              );
            })

      ),
    );
  }

  _homeContainer({required BuildContext context , String? imageUrl, double? screenWidth}){
    return  LayoutBuilder(
      builder: (context, constraints) {
        double containerHeight = constraints.maxHeight * 0.25; // 25% of available height
        double containerWidth = constraints.maxWidth * 0.45; // 45% of available width

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageZoomScreen(imageUrl: imageUrl),
              ),
            );
          },
          child: Container(

            margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
            height: containerHeight,
            width: containerWidth,
            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.mainAppColor.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(2, 3), // changes position of shadow
                  ),
                ],
                image:  DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(imageUrl!))
            ),


          ),
        );
      }
    );
  }

  _loadData()async{

    var db= await GlobalClass.fireBaseDB
        .collection('quotesImages')
        .doc('mHSlN67s3G910ChbUC9N')  // Or use `.get()` for retrieving a document
        .get();
   Map data= db.data()!;
    Map fetchedData = data;

    for (var entry in fetchedData.entries) {
      var key = entry.key; // e.g., 'imageUrl'
      var value = entry.value; // URL string
      if (key.startsWith('image')) { // Adjust this condition as needed
        _imageUrls.add(value);
      }
    }


    setState(() {});
  }

}


class ImageZoomScreen extends StatelessWidget {
  final String imageUrl;

  const ImageZoomScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MoreScreensAppBar(
        color: AppColors.white,
        text: "Double tap to zoom" ,
      ),
      backgroundColor: AppColors.mainAppColor,
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          backgroundDecoration:BoxDecoration(
            color: AppColors.mainAppColor,
          ),
        ),
      ),
    );
  }

}


//
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeBloc()..add(LoadImagesEvent()),  // Load images on init
//       child: Scaffold(
//         key: GlobalClass.scaffoldKey,
//         drawer: MyDrawer(),
//        appBar:  CustomAppBar(title: "Home", imagepath: Images.hazratImage,scaffoldKey:GlobalClass.scaffoldKey, onPressed: (){
//          context.read<HomeBloc>().add(RefreshImagesEvent());
//        }),
//         body: BlocListener<HomeBloc, HomeState>(
//           listener: (context, state) {
//             if (state is HomeError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.message),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//             }
//           },
//           child: BlocBuilder<HomeBloc, HomeState>(
//             builder: (context, state) {
//               if (state is HomeLoading) {
//                 return const Loader();
//               } else if (state is HomeLoaded) {
//                 return _buildGridView(state.imageUrls);
//               } else if (state is HomeError) {
//                 return Center(child: Text(state.message));
//               }
//               return Container(); // Default case
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildGridView(List<String> imageUrls) {
//     return GridView.builder(
//       itemCount: imageUrls.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2),
//       itemBuilder: (context, index) {
//         return _homeContainer(
//           imageUrl: imageUrls[index],
//           context: context,
//         );
//       },
//     );
//   }
//
//   Widget _homeContainer({required BuildContext context, required String imageUrl}) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double containerHeight = constraints.maxHeight * 0.25;
//         double containerWidth = constraints.maxWidth * 0.45;
//
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ImageZoomScreen(imageUrl: imageUrl),
//               ),
//             );
//           },
//           child: Container(
//             margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//             height: containerHeight,
//             width: containerWidth,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(30),
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.mainAppColor.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 1,
//                   offset: const Offset(2, 3),
//                 ),
//               ],
//               image: DecorationImage(
//                 fit: BoxFit.fill,
//                 image: NetworkImage(imageUrl),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class ImageZoomScreen extends StatelessWidget {
//   final String imageUrl;
//
//   ImageZoomScreen({required this.imageUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const MoreScreensAppBar(
//         color: AppColors.white,
//         text: "Double tap to zoom" ,
//       ),
//       backgroundColor: AppColors.mainAppColor,
//       body: Center(
//         child: PhotoView(
//           imageProvider: NetworkImage(imageUrl),
//           backgroundDecoration:BoxDecoration(
//             color: AppColors.mainAppColor,
//           ),
//         ),
//       ),
//     );
//   }
//
// }
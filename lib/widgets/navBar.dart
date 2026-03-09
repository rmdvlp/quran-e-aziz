import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quran_aziz/screens/hadithScreen/hadiths_screen.dart';
import 'package:quran_aziz/screens/quranScreen/quran_screen.dart';
import 'package:quran_aziz/widgets/drawer.dart';
import '../screens/home_screen.dart';
import '../screens/ibadatScreen/ibadat_screen.dart';
import '../screens/moreScreen/moreInfo_screen.dart';
import '../utils/colors.dart';
import '../utils/images.dart';

class MyNavBar extends StatefulWidget {
  final Function? onPressed;
  final int initialIndex;
  const MyNavBar({super.key, this.onPressed, this.initialIndex = 2});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final iconList = <IconData>[
    Icons.book,
    Icons.brightness_5_rounded,
    Icons.brightness_4,
    Icons.waving_hand_sharp,
    Icons.more_time_rounded,
  ];
  late int _selectedIndex;
  final Map<int, Widget> _loadedPages = {};

  void _onItemTapped(int index) {
    if (!_loadedPages.containsKey(index)) {
      _loadedPages[index] = _buildPage(index);
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    _loadedPages[_selectedIndex] = _buildPage(_selectedIndex);
    super.initState();
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const QuranScreen();
      case 1:
        return const HadithScreen();
      case 2:
        return const MyHomePage();
      case 3:
        return const IbadatScreen();
      case 4:
        return const MoreInfoScreen();
      default:
        return const MyHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _key,
        drawer: screenWidth > 800 ? _buildDrawer() : const MyDrawer(),
        body: IndexedStack(
          index: _selectedIndex,
          children: List.generate(
            iconList.length,
            (index) => _loadedPages[index] ?? const SizedBox.shrink(),
          ),
        ),
        floatingActionButton: SizedBox(
          height: 65,
          width: 65,
          child: FloatingActionButton(
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.grey, // Border color
                width: 4.0, // Border width
              ),
            ), // Your icon for the FAB
            backgroundColor: AppColors.mainAppColor,
            onPressed: () {
              setState(() {});
              _onItemTapped(2);
              // Navigator.push(context, MaterialPageRoute(builder: (context) =>MyHomePage()));
            },
            child: Icon(Icons.home,
                color: _selectedIndex == 2 ? AppColors.white : Colors.grey),
            //params
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar:
            // isWeb? null:
            AnimatedBottomNavigationBar(
          icons: iconList,
          activeIndex: _selectedIndex,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.sharpEdge,

          leftCornerRadius: 30,
          rightCornerRadius: 30,
          backgroundColor: AppColors.mainAppColor,
          // Set background color here
          activeColor: AppColors.white,
          // Active item color
          inactiveColor: Colors.grey,
          // Inactive item color

          onTap: (index) {
            if (index == 4) {
              _key.currentState?.openDrawer();
              _onItemTapped(index);
              return;
            }
            _onItemTapped(index);
          },
        ));
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppColors.mainAppColor,
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 45.0,
                  backgroundImage: AssetImage(Images.quranAzizImage),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Quran-e-Aziz',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _listTile(
                  text: "Contact Us",
                  icon: Icons.contact_phone,
                  onTap: () => _showContactOptions(context),
                ),
                _listTile(
                  text: "Logout",
                  icon: Icons.logout,
                  onTap: () => _logout(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listTile(
      {required String text,
      required IconData icon,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  void _showContactOptions(BuildContext context) {
    // Implement your contact options logic here
  }

  void _logout(BuildContext context) {
    // Implement your logout logic here
  }
}

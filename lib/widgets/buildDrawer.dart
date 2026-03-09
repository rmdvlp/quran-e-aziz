import 'package:flutter/material.dart';
import 'package:quran_aziz/screens/hadithScreen/hadiths_screen.dart';
import 'package:quran_aziz/screens/home_screen.dart';
import 'package:quran_aziz/screens/ibadatScreen/ibadat_screen.dart';
import 'package:quran_aziz/screens/moreScreen/moreInfo_screen.dart';

import '../screens/quranScreen/quran_screen.dart';
import '../utils/colors.dart';
import '../utils/images.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
              // QuranScreen(),
              // HadithScreen(),
              // MyHomePage(),
              // IbadatScreen(),
              // MoreInfoScreen(),
              children: [
                _listTile(
                    text: "Dashboard",
                    icon: Icons.contact_phone,
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage()))
                ),
                _listTile(
                  text: "Quran",
                  icon: Icons.contact_phone,
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const QuranScreen())),
                ),
                _listTile(
                  text: "Hadiths",
                  icon: Icons.contact_phone,
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HadithScreen())),
                ),
                _listTile(
                  text: "Ibadat",
                  icon: Icons.contact_phone,
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const IbadatScreen()))
                ),
                _listTile(
                  text: "More",
                  icon: Icons.contact_phone,
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MoreInfoScreen()))
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
  Widget _listTile({required String text, required IconData icon, required VoidCallback onTap}) {
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

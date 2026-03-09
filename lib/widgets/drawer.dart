import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quran_aziz/screens/authScreen/login_screen.dart';
import 'package:quran_aziz/utils/apptheme.dart';
import 'package:quran_aziz/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/images.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.mainAppColor,
      child: Column(
        children: [
          // Top part with image
           DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 45.0,
                  backgroundImage: AssetImage(Images.quranAzizImage), // Company logo image
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
          // Content Section
          Expanded(
            child: ListView(
              children: [
                _listTile(text: "Contact Us" , icon: Icons.contact_phone,onTap: ()=>_showContactOptions(context),),
                _listTile(text: "Logout" , icon: Icons.logout,onTap: ()=>_logout(context))


              ],
            ),
          ),
          // Bottom Section with version and company name
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Version 1.0.0',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 5),
                Text(
                  '© Re_Tech_997',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _listTile({String? text, IconData? icon,void Function()? onTap}){
    return   ListTile(
      leading:  Icon(icon,color: AppColors.white),
      title: Text(text!,style: AppTheme.textTheme.labelSmall,),
      onTap: onTap
    );
  }

  _logout(BuildContext context)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  _signOutFirebase(context);

  }
   _signOutFirebase(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen())); // Navigate to login screen after sign-out
    } catch (e) {
      print('Error signing out: $e');
      // Show a message to the user if sign-out fails
    }
  }void _showContactOptions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.mainAppColor,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.phone,color: AppColors.white),
              title: Text('Call Us',style: AppTheme.textTheme.labelSmall,),
              onTap: () {
                Navigator.pop(context);
                _launchPhone("03244544220");
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat,color: AppColors.white,),
              title: Text('WhatsApp',style: AppTheme.textTheme.labelSmall,),
              onTap: () {
                Navigator.pop(context);
                _launchWhatsApp("03244544220");
              },
            ),
          ],
        );
      },
    );
  }

  void _launchPhone(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching phone call: $e');
    }
  }

  void _launchWhatsApp(String phoneNumber) async {
    final url = 'https://wa.me/$phoneNumber'; // WhatsApp API URL
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching WhatsApp: $e');
    }
  }
}
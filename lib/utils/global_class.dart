

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GlobalClass {
     static bool changeColor = false;

     static dynamic globalIndex =5;
     static  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(); // Declare your GlobalKey

     static var fireBaseDB = FirebaseFirestore.instance;
     // static var fireBaseStorage = FirebaseStorage.instance;


}
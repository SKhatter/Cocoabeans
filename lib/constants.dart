import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocoabeans/controllers/auth_controller.dart';
import 'package:cocoabeans/views/screens/add_video_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


//COLORS
const backgroundColor = Colors.black;
const buttonColor = Color.fromARGB(255, 41, 173, 194);
const borderColor = Color.fromARGB(255, 149, 122, 122);


//NAMES
const appname = 'Cocoabeans';


// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//CONTROLLERS
var authController = AuthController.instance;


const pages = [
  Text('Home Screen'),
   Text('Search Screen'),
    AddVideoScreen(),
     Text('Messages Screen'),
     Text('Profile Screen'),
];
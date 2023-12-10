import 'package:cocoabeans/constants.dart';
import 'package:cocoabeans/controllers/auth_controller.dart';
import 'package:cocoabeans/views/screens/auth/login_screen.dart';
import 'package:cocoabeans/views/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthController());
  });
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{

  const MyApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yabber TV',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: LoginScreen(),
    );
  }
}


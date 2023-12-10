import 'dart:io';
import 'package:cocoabeans/constants.dart';
import 'package:cocoabeans/views/screens/auth/login_screen.dart';
import 'package:cocoabeans/views/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cocoabeans/models/user.dart' as usermodel;
import 'package:image_picker/image_picker.dart';


class AuthController extends GetxController{


  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;
  //Rx<File?>? _pickedImage; //RX means observable, stream of events. 
  //File? get profilePhoto => _pickedImages.value;

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user){

    if(user == null){
      Get.offAll(() => LoginScreen());
    }
    else{
      Get.offAll(() => const HomeScreen());
    }
  }

  void pickImage() async{

    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      Get.snackbar("profile picture", "you have sucessfully selected your prodile picture");
    }
    else{
      Get.snackbar("profile picture", "NOT UPLOADED");
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));

  }

Future<String> _uploadToStorage(File image) async{
  Reference ref = firebaseStorage
              .ref()
              .child('profilePics')
              .child(firebaseAuth.currentUser!.uid);

  UploadTask uploadTask = ref.putFile(image);
  TaskSnapshot snap = await uploadTask;
  String downloadUrl = await snap.ref.getDownloadURL();
  return downloadUrl;

}



 void registerUser(String username, String email, String password) async {
 //, File? image) async {
  try{

    if(username.isNotEmpty && 
        email.isNotEmpty && 
        password.isNotEmpty //&& 
       // image != null
        ){

          UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, 
            password: password
          );

         //String downlaodurl = await _uploadToStorage(image);
         usermodel.User user = usermodel.User(
                                name: username, 
                                email: email, 
                                uid: cred.user!.uid);//,
                               // profilePhoto: downlaodurl);


          await firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

    }
    else{
      Get.snackbar('Error creating account', 'please enter all the fields');
    }
  }
  catch(e){
      Get.snackbar('Error creating an account', e.toString());
    }
}

void loginUser(String email, String password) async{

  try{
    if(email.isNotEmpty && password.isNotEmpty){
        await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        print('log success');
    } else{
      Get.snackbar("Error logging in", "Please enter all the fields");
    }
  }catch(e){
    Get.snackbar("Error creating account", e.toString());
  }
}

  

}
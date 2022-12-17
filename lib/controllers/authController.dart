
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/firbase.dart';
import '../models/user.dart';
import '../screens/Auth/auth_screen.dart';
import '../screens/home/homeScreen.dart';


class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  RxBool isLoggedIn = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController Opt = TextEditingController();
  var userModel = UserModel().obs;
  

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());

    ever(firebaseUser, _setInitialScreen);
  }

  void signOut() async {
    auth.signOut();
  }

 

 



  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => AuthScreen());
    } else {
      // ===== in case it doesnt work
      userModel.bindStream(listenToUser());
      Get.offAll(() => HomeScreen());
    }
  }

  void signIn() async {
    //showLoading();
    try {
      await auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      Get.offAll(() => HomeScreen());
      _clearControllers();
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        'Sign In Failed',
        'Try again',
        // snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signUp() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      )
          .then((result) {
        String _userId = result.user!.uid;
        // _addUserToFirestore(_userId);
        setUser(UserModel(
          name: name.text.trim(),
          email: email.text.trim(),
          id: _userId,
        ));
        _clearControllers();
      });
      Get.offAll(() => HomeScreen());
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        'Sign Up Failed',
        'Try again',
        //snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  _clearControllers() {
    name.clear();
    email.clear();
    password.clear();
  }

  ///====== getting all the users who
  ///created account name and email

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection('users')
      .doc(firebaseUser.value!.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromJson(snapshot));

  //======= Set new user =======
  Future<void> setUser(UserModel userModel) {
    return firebaseFirestore
        .collection('users')
        .doc(userModel.id)
        .set(userModel.toMap());
  }
}

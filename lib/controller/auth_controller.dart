import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_note/core/route/app_route.dart';

class AuthController extends GetxController{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  Future<void> register(String email, String password, String name) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(userCredential.user?.email != null){
        firestore.collection("user").doc(userCredential.user?.email).set({
          "name": name,
          "email": email
        }).then((value){
          Fluttertoast.showToast(msg: "Sign Up Successful!");
          AppRoute().router.go("/home");
          isLoading.value = false;
        }).catchError((e){
          log(e.toString());
          isLoading.value = false;
          Fluttertoast.showToast(msg: e.toString());
        });
      }else{
        isLoading.value = false;
      }
    } on Exception catch (e) {
      log(e.toString());
      isLoading.value = false;
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(userCredential.user?.email != null){
        firestore.collection("user").doc(userCredential.user?.email).get().then((value){
          if(value.data()?['email'] != null){
            Fluttertoast.showToast(msg: "Sign In Successful!");
            AppRoute().router.go("/home");
            isLoading.value = false;
          }else{
            Fluttertoast.showToast(msg: "Please first Create Account");
            AppRoute().router.go("/home");
            AppRoute().router.push("/register");
            isLoading.value = false;
          }
        }).catchError((e){
          log(e.toString());
          isLoading.value = false;
          Fluttertoast.showToast(msg: e.toString());
        });
      }else{
        isLoading.value = false;
      }
    } on Exception catch (e) {
      log(e.toString());
      isLoading.value = false;
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
      Fluttertoast.showToast(msg: "LogOut Successful!");
      AppRoute().router.go("/login");
    } catch (e) {
      log(e.toString());
    }
  }
}
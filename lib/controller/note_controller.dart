import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:online_note/core/route/app_route.dart';
import 'package:online_note/model/note_model.dart';

class NoteController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<NoteModel?> noteList = RxList([]);
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  Future<void> addNote(String title, String desc) async {
    try {
      isLoading.value = true;
      firestore.collection("note").doc(_auth.currentUser?.email).collection("list").add({
        "title": title,
        "desc": desc,
        "createdAt": FieldValue.serverTimestamp(),
      }).then((value){
        Fluttertoast.showToast(msg: "Note Add Successful!");
        isLoading.value = false;
        AppRoute().router.go("/home");
      }).catchError((e){
        log(e.toString());
        isLoading.value = false;
        Fluttertoast.showToast(msg: e.toString());
      });
    } on Exception catch (e) {
      log(e.toString());
      isLoading.value = false;
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
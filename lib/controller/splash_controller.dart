import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:online_note/core/route/app_route.dart';

class SplashController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> navigation() async{
    if(_auth.currentUser != null){
      Future.delayed(const Duration(seconds: 3),(){
        AppRoute().router.go("/home");
      });
    }else{
      Future.delayed(const Duration(seconds: 3),(){
        AppRoute().router.go("/login");
      });
    }
  }

  @override
  void onReady() {
    super.onReady();
    navigation();
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:online_note/constant/app_images.dart';
import 'package:online_note/controller/auth_controller.dart';
import 'package:online_note/view/widget/button/custom_button.dart';
import 'package:online_note/view/widget/text_field/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100,width: width-100,child: SvgPicture.asset(AppImages.logo,height: 100,width: width-100,)),
                Text("Login Your Account And Enjoy!",style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 24,),
                CustomTextField(
                  controller: email,
                  validator: (value){
                    final bool valid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value.toString()??"");
                    if(valid){
                      return null;
                    }else{
                      return "Please Enter Email";
                    }
                  },
                  hint: "Please Enter Email",
                  icon: Icons.email,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: password,
                  isPassword: true,
                  validator: (value){
                    final bool valid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value.toString()??"");
                    if(valid){
                      return null;
                    }else{
                      return "Please Enter Password";
                    }
                  },
                  hint: "Please Enter Password",
                  icon: Icons.lock,
                ),
                const SizedBox(height: 24),
                Obx((){
                  return CustomButton(text: "Sign In", isLoading: authController.isLoading.value,onTap: (){
                    if(formKey.currentState!.validate()){
                      authController.login(email.text.trim(), password.text.trim());
                    }
                  });
                }),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account?",style: Theme.of(context).textTheme.bodyMedium),
                    GestureDetector(onTap: (){
                      context.push("/register");
                    },child: Text("Sign Up",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

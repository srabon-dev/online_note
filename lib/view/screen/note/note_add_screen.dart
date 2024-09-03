import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_note/constant/app_colors.dart';
import 'package:online_note/controller/note_controller.dart';
import 'package:online_note/view/widget/button/custom_button.dart';
import 'package:online_note/view/widget/text_field/custom_text_field.dart';

class NoteAddScreen extends StatefulWidget {
  const NoteAddScreen({super.key});

  @override
  State<NoteAddScreen> createState() => _NoteAddScreenState();
}

class _NoteAddScreenState extends State<NoteAddScreen> {
  final NoteController noteController = Get.put(NoteController());
  final formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.orangeColor,
        title: const Text("Add Note",style: TextStyle(color: AppColors.whiteColor),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24,),
              Text("Note Title", style: Theme.of(context).textTheme.titleMedium),
              CustomTextField(
                controller: title,
                validator: (value){
                  if(value != null){
                    return null;
                  }else{
                    return "Please Enter Note Title";
                  }
                },
                minLines: 1,
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              Text("Note Description", style: Theme.of(context).textTheme.titleMedium),
              CustomTextField(
                controller: desc,
                validator: (value){
                  if(value != null){
                    return null;
                  }else{
                    return "Please Enter Description";
                  }
                },
                maxLines: 10,
                minLines: 6,
              ),
              const SizedBox(height: 24),
              Obx((){
                return CustomButton(text: "Save", isLoading: noteController.isLoading.value,onTap: (){
                  if(formKey.currentState!.validate()){
                    noteController.addNote(title.text, desc.text);
                  }
                });
              }),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

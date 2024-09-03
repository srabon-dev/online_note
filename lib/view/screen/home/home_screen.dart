import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:online_note/constant/app_colors.dart';
import 'package:online_note/controller/auth_controller.dart';
import 'package:online_note/model/note_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>context.push("/add_note"),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.orangeColor,
        title: const Text("Note",style: TextStyle(color: AppColors.whiteColor),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () {
                authController.logout();
              },
              icon: const Icon(Icons.logout,color: AppColors.whiteColor,),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: authController.firestore.collection("note").doc(authController.auth.currentUser?.email).collection("list").orderBy("createdAt", descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.orangeColor,));
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No notes found",style: Theme.of(context).textTheme.titleMedium));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var doc = snapshot.data!.docs[index];
              NoteModel note = NoteModel.fromJson(doc.data() as Map<String, dynamic>);
              return Card(
                child: ListTile(
                  title: Text(note.title ?? ""),
                  subtitle: Text(note.desc ?? ""),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

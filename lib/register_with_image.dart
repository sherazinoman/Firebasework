import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class RegisterWithImage extends StatefulWidget {
  const RegisterWithImage({super.key});

  @override
  State<RegisterWithImage> createState() => _RegisterWithImageState();
}

class _RegisterWithImageState extends State<RegisterWithImage> {

  Uint8List? webImage;
  File? mobileImage;

  final TextEditingController userName = TextEditingController();
  final TextEditingController userAge = TextEditingController();
  final TextEditingController userGender = TextEditingController();
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();


  void userWithImage()async{

    String itemID = const Uuid().v1();

    UploadTask uploadTask = FirebaseStorage.instance.ref().child("images").child(itemID).putData(webImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    userAuth(ID: itemID,image: imageUrl);
  }

  void userAuth({String? ID, String? image})async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userEmail.text, password: userPassword.text);
      FirebaseFirestore.instance.collection("dataimage").doc(ID).set({
        "id" :ID,
        "name" : userName.text,
        "age" : userAge.text,
        "gender" : userGender.text,
        "email" : userEmail.text,
        "password" : userPassword.text,
        "image" :image,
      });

    }catch(ex){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            SizedBox(
              height: 10,
            ),

            GestureDetector(
              onTap: ()async{
               if(kIsWeb){
                 XFile? pickkImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                 if(pickkImage != null){
                   var convertedFile = await pickkImage.readAsBytes();
                   setState(() {
                     webImage = convertedFile;
                   });
                 }else{
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image not picked")));
                 }
               }else{
                 XFile? pickkImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                 if(pickkImage != null){
                   var convertedFile = File(pickkImage.path);
                   setState(() {
                     mobileImage = convertedFile;
                   });
                 }else{
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image not picked")));
                 }
               }
              },
              child: CircleAvatar(
                radius: 60,
                backgroundImage: webImage!=null ? MemoryImage(webImage!) : null,
                backgroundColor: Colors.blue,
              ),
            ),

            SizedBox(height: 10,),

            TextFormField(
              controller: userName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person)
              ),
            ),
            SizedBox(height: 10,),

            TextFormField(
              controller: userAge,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.auto_graph_outlined)
              ),
            ),
            SizedBox(height: 10,),

            TextFormField(
              controller: userGender,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.grade)
              ),
            ),
            SizedBox(height: 10,),

            TextFormField(
              controller: userEmail,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email)
              ),
            ),
            SizedBox(height: 10,),

            TextFormField(
              controller: userPassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.password)
              ),
            ),
            SizedBox(height: 10,),

            ElevatedButton(onPressed: (){
              userWithImage();
            }, child: Text("Register"))

          ],
        ),
      ),
    );
  }
}

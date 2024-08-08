import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController userAge = TextEditingController();
  final TextEditingController userGender = TextEditingController();
  final TextEditingController userPassword = TextEditingController();

  void addData()async{
    String userID = Uuid().v1();

    Map<String, dynamic> userData = {
      // C  : // Rows
      "id": userID,
      "userName" : userName.text,
      "userAge" : userAge.text,
      "userGender" : userGender.text,
      "userEmail" : userEmail.text,
      "userPassword" : userPassword.text,
    };

                                     // TN
    // await FirebaseFirestore.instance.collection("users").add(userData); // Automatic ID Generate
    await FirebaseFirestore.instance.collection("users").doc(userID).set(userData); // ID generate UUID
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data Inserted")));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    userEmail.dispose();
    userName.dispose();
    userAge.dispose();
    userGender.dispose();
    userPassword.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(

          children: [


            const SizedBox(height: 10,),

            TextFormField(
              controller: userName,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter name"
              ),
            ),

            const SizedBox(height: 10,),

            TextFormField(
              controller: userAge,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Age"
              ),
            ),

            const SizedBox(height: 10,),

            TextFormField(
              controller: userGender,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Gender"
              ),
            ),


            TextFormField(
              controller: userEmail,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Email"
              ),
            ),

            const SizedBox(height: 10,),

            TextFormField(
              controller: userPassword,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Password"
              ),
            ),

            const SizedBox(height: 10,),

            ElevatedButton(onPressed: (){
              addData();
            }, child: const Text("Add Data")),

            const SizedBox(height: 10,),



          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tts09bf/add_user.dart';

class FetchUser extends StatefulWidget {
  const FetchUser({super.key});

  @override
  State<FetchUser> createState() => _FetchUserState();
}

class _FetchUserState extends State<FetchUser> {


  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }

            if(snapshot.hasData){
              var dataLength = snapshot.data!.docs.length;
              return dataLength != 0 ? ListView.builder(
                itemCount: dataLength,
                itemBuilder: (context, index) {

                  String userName = snapshot.data!.docs[index]['userName'];
                  String userEmail = snapshot.data!.docs[index]['userEmail'];
                  String userAge = snapshot.data!.docs[index]['userAge'];
                  String userGender = snapshot.data!.docs[index]['userGender'];
                  String userPassword = snapshot.data!.docs[index]['userPassword'];

                  return ListTile(
                    title: Text(userName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userEmail),
                        Text(userAge)
                      ],
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [

                          //Update
                          IconButton(onPressed: (){
                            showModalBottomSheet(context: context, builder: (context) {
                              return StatefulBuilder(builder: (context, setState) {
                                setState((){
                                  name.text = userName;
                                  email.text = userEmail;
                                  age.text = userAge;
                                  gender.text = userGender;
                                  password.text = userPassword;
                                });
                                return Container(
                                  width: double.infinity,
                                  child: Column(
                                    children: [

                                      const SizedBox(height: 10,),

                                      const Text("Update Data"),

                                      Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                        child: TextFormField(
                                          controller: name,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                            ),
                                            hintText: "Enter Your Name"
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                        child: TextFormField(
                                          controller: age,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                              ),
                                              hintText: "Enter Your Age"
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                        child: TextFormField(
                                          controller: gender,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                              ),
                                              hintText: "Enter Your Gender"
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                        child: TextFormField(
                                          controller: email,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                              ),
                                              hintText: "Enter Your Email"
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                        child: TextFormField(
                                          controller: password,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                              ),
                                              hintText: "Enter Your Password"
                                          ),
                                        ),
                                      ),
                                      
                                      ElevatedButton(onPressed: ()async{
                                        await FirebaseFirestore.instance.collection("users").doc(snapshot.data!.docs[index].id).update(
                                            {
                                              "userName" : name.text,
                                              "userAge" : age.text,
                                              "userGender" : gender.text,
                                              "userEmail" : email.text,
                                              "userPassword" : password.text,
                                            });
                                        Navigator.pop(context);
                                      }, child: Text("Update Screen"))

                                    ],
                                  ),
                                );
                              },);
                            },);
                          }, icon: const Icon(Icons.edit)),

                          // Delete
                          IconButton(onPressed: ()async{
                            await FirebaseFirestore.instance.collection("users").doc(snapshot.data!.docs[index].id).delete();
                          }, icon: const Icon(Icons.delete,color: Colors.red,)),
                        ],
                      ),
                    )
                  );
                },) : const Center(child: Text("Nothing to show"),);
            }

            if(snapshot.hasError){
              return const Center(child: Icon(Icons.error,color: Colors.red,),);
            }

            return Container();
          },),


      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddUser(),));
        },child: const Icon(Icons.add),),
    );
  }
}

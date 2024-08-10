import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tts09bf/image_screen.dart';

class UserFetchWithImage extends StatefulWidget {
  const UserFetchWithImage({super.key});

  @override
  State<UserFetchWithImage> createState() => _UserFetchWithImageState();
}

class _UserFetchWithImageState extends State<UserFetchWithImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("imageuser").snapshots(),
          builder: (BuildContext context,  snapshot) {
            if (snapshot.hasData) {
              var dataLength =snapshot.data!.docs.length;
              return ListView.builder(
                itemCount: dataLength,
                itemBuilder: (context, index) {
                String userImage = snapshot.data!.docs[index]['image'];
                String userName = snapshot.data!.docs[index]['name'];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(userImage),
                  ),
                  title: Text(userName),
                  trailing: IconButton(onPressed: ()async{
                    await FirebaseFirestore.instance.collection("imageuser").doc(snapshot.data!.docs[index].id).delete();
                    await FirebaseStorage.instance.refFromURL(userImage).delete();
                  }, icon: Icon(Icons.delete,color: Colors.red,)),
                );
              },);
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return CircularProgressIndicator();
            }
          }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context,  MaterialPageRoute(builder: (context) => ImageScreen(),));
      },child: Icon(Icons.add),),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {

  Uint8List? webImage;
  final TextEditingController name = TextEditingController();

  void AddDataWithImage()async{
    UploadTask uploadTask = FirebaseStorage.instance.ref().putData(webImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String userImage = await taskSnapshot.ref.getDownloadURL();
    addData(userImage);
  }

  void addData(String? image){
    FirebaseFirestore.instance.collection("imageuser").add({
      "name" : name.text,
      "image" : image
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            GestureDetector(
              onTap: ()async{
                XFile? pickImage  = await ImagePicker().pickImage(source: ImageSource.gallery);
                if(pickImage != null){
                  // XFile convert uInt8List
                  var convertedImage = await pickImage.readAsBytes();
                  setState(() {
                    webImage = convertedImage;
                  });
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image Not Selected")));
                }
              },
              child: CircleAvatar(
                backgroundImage: webImage != null ? MemoryImage(webImage!) : null,
                radius: 60,
              ),
            ),


            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: 250,
              child: TextFormField(
                controller: name,
              ),
            ),


            const SizedBox(
              height: 10,
            ),

            ElevatedButton(onPressed: ()async{
              AddDataWithImage();
            }, child: const Text("Pick Image"))

          ],
        ),
      ),
    );
  }
}

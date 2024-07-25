import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tts09bf/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();

  void userRegister()async{

    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userEmail.text, password: userPassword.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Register Successful")));
    } catch (ex){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ex.toString())));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(

          children: [

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
              userRegister();
            }, child: const Text("Register")),

            const SizedBox(height: 10,),

            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
                },
                child: const Text("Already have an Account Login"))

          ],
        ),
      ),
    );
  }
}

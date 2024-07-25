import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tts09bf/home_screen.dart';
import 'package:tts09bf/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();

  void userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmail.text, password: userPassword.text);
      SharedPreferences userCred = await SharedPreferences.getInstance();
      userCred.setString("email", userEmail.text);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login Successful")));
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    } catch (ex) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(ex.toString())));
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
                  border: OutlineInputBorder(), hintText: "Enter Email"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: userPassword,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter Password"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  userLogin();
                },
                child: const Text("Login")),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ));
                },
                child: const Text("Don't have an Account Create One"))
          ],
        ),
      ),
    );
  }
}

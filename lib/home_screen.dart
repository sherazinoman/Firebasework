import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tts09bf/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String uEmail = "";

  Future getUser() async {
    SharedPreferences userCred = await SharedPreferences.getInstance();
    var userEmail = userCred.getString("email");
    return userEmail;
  }

  void userLogout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences userCred = await SharedPreferences.getInstance();
    userCred.clear();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser().then((value) {
      setState(() {
        uEmail = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () {
              userLogout();
            },
            child: Text(uEmail)),
      ),
    );
  }
}

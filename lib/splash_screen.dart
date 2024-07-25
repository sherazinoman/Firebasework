import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tts09bf/home_screen.dart';
import 'package:tts09bf/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future getUser() async {
    SharedPreferences userCred = await SharedPreferences.getInstance();
    var userEmail = userCred.getString("email");
    return userEmail;
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser().then((value) => {
          if (value != null)
            {
              Timer(const Duration(milliseconds: 3000), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ));
              })
            }
          else
            {
              Timer(const Duration(milliseconds: 3000), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              })
            }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}

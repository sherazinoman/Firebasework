import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tts09bf/add_user.dart';
import 'package:tts09bf/fetch_user.dart';
import 'package:tts09bf/firebase_options.dart';
import 'package:tts09bf/image_screen.dart';
import 'package:tts09bf/login_screen.dart';
import 'package:tts09bf/register_with_image.dart';
import 'package:tts09bf/splash_screen.dart';
import 'package:tts09bf/user_fetch_with_image.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegisterWithImage(),
      debugShowCheckedModeBanner: false,
    );
  }
}





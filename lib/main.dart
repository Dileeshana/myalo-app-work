import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'identifiyng_quiz/identify_quiz.dart';
import 'login/login.dart';
import 'severity_checkup/landing_screen.dart';
import 'treatment_method_1/acrophobia/acrophobia_landing.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: IdentifyQuiz(),
      // home: LoginPage(),
    );
  }
}

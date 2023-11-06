import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myalo_app/identifiyng_quiz/questionscreen.dart';
import 'package:myalo_app/severity_checkup/severity_quiz.dart';

import 'identifiyng_quiz/identify_quiz.dart';
import 'login/login.dart';
import 'severity_checkup/landing_screen.dart';
import 'package:myalo_app/treatment_method_1/acrophobia/acrophobia_landing.dart';
import 'vr/vr.dart';
import 'vr/vr_player.dart';

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
      //home: SeverityQuiz(),
      home: LoginPage(),
      // home: QuestionScreen("severity-ac"), //vr check
      //home: IdentifyQuiz(),
      // home: AcrophobiaLanding(),
    );
  }
}

// ignore_for_file: unused_import

// ignore: avoid_web_libraries_in_flutter
// import 'dart:js';

import 'package:flutter/material.dart';
import 'severity_quiz.dart';

class SeverityLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        toolbarHeight: 50,
        elevation: 0,
        title: Center(
          child: Text("Severity Checking"),
        ),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 55),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            const Text("You complete the Sickness Identification.",
                style: TextStyle(height: 7)),
            const Text("Let`s check the severity of your ilness."),
            Spacer(flex: 1),
            _getStartedQuizButton(context),
            Spacer(flex: 5)
          ],
        ),
      ),
    );
  }

  _getStartedQuizButton(BuildContext context) {
    
    return Container(
      width: 200,
      height: 40,
      child: ElevatedButton(
        child: Text("Get Started"),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          primary: Colors.blue.shade600,
          onPrimary: Color.fromARGB(230, 255, 255, 255),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SeverityQuiz()));
        },
      ),
    );
  }
}

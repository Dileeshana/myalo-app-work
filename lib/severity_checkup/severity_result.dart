// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:myalo_app/login/patient.dart';
import '../treatment_method_1/acrophobia/acrophobia_landing.dart';
import '../treatment_method_2/landing.dart';
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class ResultScreen extends StatelessWidget {
  final int userAnswers;
  final String severity; // Add this field

  ResultScreen(this.userAnswers, this.severity);

  @override
  Widget build(BuildContext context) {
    String resultText = ""; // Default text

    if (severity == 'severity-sa') {
      resultText = "Social Anxiety";
    } else if (severity == 'severity-sch') {
      resultText = "Schizophrenia";
    } else if (severity == 'severity-ac') {
      resultText = "Acrophobia";
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
        elevation: 0, //drop shadow
        title: const Text("Severity of Your ilness"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            const Center(
                child: Text("Results",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500, height: 3))),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  height: 80,
                  width: 200,
                  color: Color.fromARGB(204, 135, 212, 245),
                  child: Column(
                    children: [
                      const Text(
                        "You're diagnoised with",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                            height: 3.2),
                      ),
                      Text(
                        userAnswers > 10
                            ? "Mediocre/Extreme level $resultText"
                            : "Initial Level $resultText",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 1,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    userAnswers > 10
                        ? "Recommended : Mediocre/Extreme Treatment"
                        : "Recommended : Initial Treatment",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    userAnswers > 10
                        ? "Because your severity level is Mediocre/Extreme you must use Mediocre/Extreme treatment method"
                        : "Because your severity level is Initial you can use any treatment method",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(164, 0, 0, 0),
                      height: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 120), //use this for single box
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Visibility(
                      visible: userAnswers <= 10,
                      child: _initialTreatmentButton(context),
                    ),
                  ),
                  Visibility(
                    visible: userAnswers <= 10,
                    child: SizedBox(width: 20),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: _extremeTreatmentButton(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _initialTreatmentButton(BuildContext context) {
    return Container(
      width: 150,
      height: 80,
      child: ElevatedButton(
        child: Text(
          "Initial Treatments",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
            shape: LinearBorder(),
            primary: Colors.blue[100],
            onPrimary: Colors.black),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AcrophobiaLanding()));
        },
      ),
    );
  }

  _extremeTreatmentButton(BuildContext context) {
    return Container(
      width: 150,
      height: 80,
      child: ElevatedButton(
        child: Text(
          "Mediocre/Extreme Treatments",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
            shape: LinearBorder(),
            primary: Colors.blue[100],
            onPrimary: Colors.black),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HighSeverityLanding()));
        },
      ),
    );
  }

  _goback(BuildContext context) {
    return Container(
      width: 150,
      height: 80,
      child: ElevatedButton(
        child: Text(
          "Back to Home Page",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
            shape: LinearBorder(),
            primary: Colors.blue[100],
            onPrimary: Colors.black),
        onPressed: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Patient()));
        },
      ),
    );
  }
}

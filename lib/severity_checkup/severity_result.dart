// import 'dart:js';

import 'package:flutter/material.dart';
import '../treatment_method_1/acrophobia/acrophobia_landing.dart';
import '../treatment_method_2/landing.dart';
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class ResultScreen extends StatelessWidget {
  // final String severityLevel;
  // final List<String> recommendations;

  // ResultScreen({
  //   required this.severityLevel,
  //   required this.recommendations,
  // });

  @override
  Widget build(BuildContext context) {
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
            Center(
                child: Text("Results",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500, height: 3))),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 80,
                  width: 200,
                  color: Color.fromARGB(204, 135, 212, 245),
                  child: Column(
                    children: [
                      Text(
                        "You're diagnoised with",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                            height: 3.2),
                      ),
                      Text(
                        "Initial Level Acrophobia",
                        // severityLevel, //after completion backend release this
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            height: 1.2),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommend: Initial Treatment",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Because your severity level is Initial you can use any treatment method",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(164, 0, 0, 0),
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 120), //use this for single box
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _initialTreatmentButton(context),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(10),
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     height: 80,
                  //     width: 150,
                  //     color: Colors.blue[100],
                  //     child: Text(
                  //       "Initial Treatments",
                  //       style: TextStyle(fontWeight: FontWeight.w600),
                  //     ),
                  //   ),
                  // ),
                  _extremeTreatmentButton(context),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(10),
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     height: 80,
                  //     width: 150,
                  //     color: Colors.blue[100],
                  //     child: Text(
                  //       "Mediocre Treatments",
                  //       style: TextStyle(fontWeight: FontWeight.w600),
                  //     ),
                  //   ),
                  // ),
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
            onPrimary: Colors.black
            ),
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
            onPrimary: Colors.black
            ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HighSeverityLanding()));
        },
      ),
    );
  }
}

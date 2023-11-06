import 'package:flutter/material.dart';
import 'package:myalo_app/identifiyng_quiz/quiz_model.dart';
import '../severity_checkup/landing_screen.dart';

class ResultScreen extends StatelessWidget {
  final String severity; // Declare a field to store the user data

  // Constructor that accepts the user data
  ResultScreen(this.severity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
        elevation: 0, //drop shadow
        title: const Text("Identify Your Sickness"),
      ),
      body: Container(
          child: Column(
        children: [
          const Spacer(flex: 1),
          Text(
            "Result",
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: Colors.black),
          ),
          Spacer(),
          _resultz(),
          Spacer(flex: 2),
          _nextSeverityChecupButton(context),
          Spacer(flex: 5),
        ],
      )),
    );
  }

  _resultz() {
    String resultText = ""; // Default text

    if (severity == 'severity-sa') {
      resultText = "Social Anxiety";
    } else if (severity == 'severity-sch') {
      resultText = "Schizophrenia";
    } else if (severity == 'severity-ac') {
      resultText = "Acrophobia";
    }
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 224, 224, 224),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Based on the questionnaire\nDiagnosis is",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              Text(
                resultText,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _nextSeverityChecupButton(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      child: ElevatedButton(
        child: Text("Next"),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          primary: Colors.blue.shade600,
          onPrimary: Color.fromARGB(230, 255, 255, 255),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SeverityLanding(severity)));
        },
      ),
    );
  }
}

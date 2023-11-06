import 'package:flutter/material.dart';
import 'package:myalo_app/identifiyng_quiz/identified_result.dart';

class QuestionScreen extends StatefulWidget {
  final String sickness;

  QuestionScreen(this.sickness);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  String selectedAnswer = "";
  String resultText = ""; // Default text

  @override
  Widget build(BuildContext context) {
    if (widget.sickness == 'severity-sa') {
      resultText = "Social Anxiety";
    } else if (widget.sickness == 'severity-sch') {
      resultText = "Schizophrenia";
    } else if (widget.sickness == 'severity-ac') {
      resultText = "Acrophobia";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('VR 360 Question'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Did the video have any negative effects on your mood ?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: ['No', 'Maybe', 'Yes'].map((answer) {
              return Container(
                width: 350, // Set the width to your desired value
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Make it rounder
                ),
                child: ListTile(
                  title: Text(answer),
                  tileColor:
                      selectedAnswer == answer ? Colors.blue : Colors.grey,
                  onTap: () {
                    selectAnswer(answer);
                  },
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (selectedAnswer.isNotEmpty) {
                // Check if an answer is selected
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                        widget.sickness), // Navigate to ResultsScreen
                  ),
                );
              } else {
                // Handle the case when no answer is selected.
              }
            },
            child: Text('Show Results'),
          ),
        ],
      ),
    );
  }

  void selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }
}

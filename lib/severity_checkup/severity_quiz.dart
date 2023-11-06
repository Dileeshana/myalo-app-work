import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myalo_app/models/severity_quiz_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'severity_result.dart';

class SeverityQuiz extends StatefulWidget {
  final String severity; // Define a field to store the severity

  SeverityQuiz(this.severity); // Constructor to initialize the severity

  @override
  State<SeverityQuiz> createState() => _SeverityQuizState();
}

class _SeverityQuizState extends State<SeverityQuiz> {
  String severity = "";
  List<Question> questionList = [];
  int currentQuestionIndex = 0;
  Answer? selectedAnswer;
  int userAnswers = 0; // to keep track of answers

  @override
  void initState() {
    super.initState();
    severity = widget.severity;
    print(severity);
    fetchQuestionsFromFirebase().then((questions) {
      setState(() {
        questionList = questions;
      });
    });
  }

  Future<List<Question>> fetchQuestionsFromFirebase() async {
    final databaseReference = FirebaseDatabase.instance.reference();
    List<Question> questions = [];

    await databaseReference.child(severity).once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;

      List<Object?> myList = snapshot.value as List<Object?>;

      for (Object? element in myList) {
        if (element is Map<Object?, Object?>) {
          final Map<Object?, Object?> mapElement = element;

          String question = mapElement['question'].toString();
          String illness = mapElement['illness'].toString();

          List<Object?> answersList = mapElement['answers'] as List<Object?>;
          List<Answer> answerList = [];

          for (Object? answerItem in answersList) {
            if (answerItem is Map<Object?, Object?>) {
              String response = answerItem['response'].toString();
              int weight = int.parse(answerItem['weight'].toString());
              answerList
                  .add(Answer(answerWeight: weight, answerText: response));
            }
          }

          questions.add(Question(
            questionText: question,
            illness: illness,
            answerList: answerList,
          ));
        }
      }
    });

    return questions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
        elevation: 0, //drop shadow
        title: const Text("Severity Checking"),
      ),
      // backgroundColor: Color.fromARGB(251, 197, 245, 255),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _questionWidget(),
            _answerList(),
            _nextButton(),
          ],
        ),
      ),
    );
  }

  _questionWidget() {
    if (questionList.isEmpty) {
      return const CircularProgressIndicator();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 142, 196, 223),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            questionList[currentQuestionIndex].questionText,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  _answerList() {
    if (questionList.isEmpty || currentQuestionIndex >= questionList.length) {
      return const SizedBox
          .shrink(); // Return an empty widget if the questionList is not loaded or if the index is out of range
    }
    return Column(
      children: questionList[currentQuestionIndex]
          .answerList
          .map(
            (e) => _answerButton(e),
          )
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: isSelected
              ? Colors.green.shade400
              : Colors.lightBlueAccent.shade700,
          onPrimary: isSelected ? Colors.black : Colors.black,
        ),
        onPressed: () {
          setState(() {
            selectedAnswer = answer;
          });
        },
        child: Text(answer.answerText),
      ),
    );
  }

  _nextButton() {
    bool islastQuestion = currentQuestionIndex == questionList.length - 1;

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 40,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            primary: Colors.green.shade400,
            onPrimary: Colors.black,
          ),
          onPressed: () {
            if (selectedAnswer != null) {
              userAnswers += selectedAnswer?.answerWeight ?? 0;

              if (islastQuestion) {
                print(userAnswers);
                //redirect to result sheet with answers
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ResultScreen(userAnswers, severity)));
              } else {
                //next question
                setState(() {
                  selectedAnswer = null;
                  currentQuestionIndex++;
                });
              }
            } else {
              // You can show an alert or message saying "Please select an answer"
            }
          },
          child: Text(islastQuestion ? "Show Results" : "Next")),
    );
  }
}

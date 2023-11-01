import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myalo_app/identifiyng_quiz/identified_result.dart';
import 'package:firebase_database/firebase_database.dart';

import 'quiz_model.dart';

class IdentifyQuiz extends StatefulWidget {
  @override
  State<IdentifyQuiz> createState() => _IdentifyQuizState();
}

class _IdentifyQuizState extends State<IdentifyQuiz> {
  List<Question> questionList = [];
  int currentQuestionIndex = 0;
  Answer? selectedAnswer;
  Map<int, Answer> userAnswers = {}; // to keep track of answers

  @override
  void initState() {
    super.initState();
    fetchQuestionsFromFirebase().then((questions) {
      setState(() {
          questionList = questions;
      });
    });
  }

  Future<List<Question>> fetchQuestionsFromFirebase() async {
  final databaseReference = FirebaseDatabase.instance.reference();
  List<Question> questions = [];

  await databaseReference.child('questions').once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic>? questionData = snapshot.value as Map<dynamic, dynamic>?; // cast here
    // Object? questionData = snapshot.value;
    questionData!.forEach((questionId, questionDetails) {
      List<Answer> answerList = [];
      Map<dynamic, dynamic> answers = questionDetails['answers']as Map<dynamic, dynamic>;

      answers.forEach((answerId, answerText) {
        answerList.add(Answer(answerId: int.parse(answerId), answerText: answerText));
      });

      questions.add(
        Question(
          questionText: questionDetails['text'],
          illness: questionDetails['illness'],
          MID: questionDetails['MID'],
          answerList: answerList,
        ),
      );
    });
  } as FutureOr Function(DatabaseEvent value));

  return questions;
}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
        elevation: 0, //drop shadow
        title: const Text("Identify Your Sickness"),
      ),
      // backgroundColor: Color.fromARGB(251, 197, 245, 255),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // const Text(
            //   "Identify Your Sickness",
            //   style: TextStyle(
            //     color: Colors.black87,
            //     fontSize: 22,
            //   ),
            // ),
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
      return const CircularProgressIndicator(); // Show a loading spinner if questions are not loaded yet
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
            color: Color.fromARGB(255, 30, 168, 236),
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
    return SizedBox.shrink();  // Return an empty widget if the questionList is not loaded or if the index is out of range
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


  // _answerList() {
  //   return Column(
  //     children: questionList[currentQuestionIndex]
  //         .answerList
  //         .map(
  //           (e) => _answerButton(e),
  //         )
  //         .toList(),
  //   );
  // }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 40,
      child: ElevatedButton(
        child: Text(answer.answerText),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: isSelected
              ? Color.fromARGB(255, 9, 180, 17)
              : Color.fromARGB(255, 160, 220, 255),
          onPrimary: isSelected
              ? const Color.fromARGB(255, 255, 255, 255)
              : Colors.black,
        ),
        onPressed: () {
          setState(() {
            selectedAnswer = answer;
          });
        },
      ),
    );
  }

  _nextButton() {
    bool islastQuestion = currentQuestionIndex == questionList.length - 1;

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 40,
      child: ElevatedButton(
          child: Text(islastQuestion ? "Show Results" : "Next"),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            primary: Colors.green.shade400,
            onPrimary: Colors.black,
          ),
          onPressed: () {
            if (selectedAnswer != null) {
              userAnswers[currentQuestionIndex] = selectedAnswer!;

              if (islastQuestion) {
                //redirect to result sheet with answers
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultScreen(userAnswers)));
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
          }),
    );
  }

}

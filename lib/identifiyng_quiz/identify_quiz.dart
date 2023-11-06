import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myalo_app/identifiyng_quiz/identified_result.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:myalo_app/vr/vr.dart';
import 'quiz_model.dart';
import 'dart:math';

class IdentifyQuiz extends StatefulWidget {
  @override
  State<IdentifyQuiz> createState() => _IdentifyQuizState();
}

class _IdentifyQuizState extends State<IdentifyQuiz> {
  List<Question> questionList = [];
  int currentQuestionIndex = 0;
  Answer? selectedAnswer;
  Map<int, Answer> userAnswers = {}; // to keep track of answers
  final Map<int, int> answerScores = {};

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

    await databaseReference
        .child('questions')
        .once()
        .then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      List<Object?> myList = snapshot.value as List<Object?>;

      // Create a map to keep track of questions for each MID
      Map<int, List<Question>> midQuestionsMap = {};

      for (Object? element in myList) {
        if (element is Map<Object?, Object?>) {
          final Map<Object?, Object?> mapElement = element;
          String text = mapElement['text'].toString();
          String illness = mapElement['illness'].toString();
          int mid = int.parse(mapElement['MID'].toString());
          final List<Object?> answersList =
              mapElement['answers'] as List<Object?>;

          List<Answer> answerList = [];
          answersList.forEach((answerItem) {
            if (answerItem != null) {
              answerList.add(Answer(
                answerId: mid, // Assign an appropriate answer ID
                answerText: answerItem.toString(),
              ));
            }
          });

          Question question = Question(
            questionText: text,
            illness: illness,
            MID: mid,
            answerList: answerList,
          );

          // Add the question to the MID-specific list
          midQuestionsMap[mid] ??= [];
          midQuestionsMap[mid]!.add(question);
        }
      }

      // Shuffle and take exactly 3 questions for each MID
      midQuestionsMap.forEach((mid, midQuestions) {
        if (midQuestions.length >= 3) {
          midQuestions.shuffle();
          questions.addAll(midQuestions.take(3));
        } else {
          questions.addAll(midQuestions);
        }
      });

      // Randomly select one additional question from MIDs 1, 2, or 3
      List<int> midsToChooseFrom = [1, 2, 3];
      midsToChooseFrom.shuffle();
      int additionalMid = midsToChooseFrom.first;
      questions.add(midQuestionsMap[additionalMid]!.first);

      // Shuffle all the questions again and limit the total number to 10
      questions.shuffle();
      questions = questions.take(10).toList();
    });

    Question question = Question(
      questionText: "You will be played a 360 VR now.",
      illness: "",
      MID: 0,
      answerList: [],
    );
    questions.add(question);
    print(questions.length);
    return questions;
  }

  @override
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
          child: Text(islastQuestion ? "Play 360 VR Clip" : "Next"),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            primary: Colors.green.shade400,
            onPrimary: Colors.black,
          ),
          onPressed: () {
            if (selectedAnswer != null || islastQuestion) {
              if (!islastQuestion) {
                userAnswers[currentQuestionIndex] = selectedAnswer!;
                print(selectedAnswer?.answerId);

                if (selectedAnswer!.answerId != null) {
                  if (selectedAnswer!.answerText == "Yes") {
                    answerScores.update(
                      selectedAnswer!.answerId!,
                      (value) => value + 2,
                      ifAbsent: () => 2,
                    );
                  } else if (selectedAnswer!.answerText == "Maybe") {
                    answerScores.update(
                      selectedAnswer!.answerId!,
                      (value) => value + 1,
                      ifAbsent: () => 1,
                    );
                  }
                  // No is 0, so no need to update for "No" answers.
                }
              }
              if (islastQuestion) {
                int highestScoringAnswerId = 0;
                int highestScore = 0;
                String sickness = "severity-sa";

                answerScores.forEach((answerId, score) {
                  if (score > highestScore) {
                    highestScoringAnswerId = answerId;
                    highestScore = score;
                  }
                });

                if (highestScoringAnswerId == 2) {
                  sickness = "severity-sch";
                } else if (highestScoringAnswerId == 3) {
                  sickness = "severity-ac";
                }
                // print(highestScoringAnswerId);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VR(sickness)));
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ResultScreen(sickness)));
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
//1:social - severity-sa
//2:schz  - severity-sch
//3:acro -severity -ac
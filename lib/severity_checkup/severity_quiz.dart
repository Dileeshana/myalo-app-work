import 'package:flutter/material.dart';
import 'package:myalo_app/models/severity_quiz_model.dart';

import 'severity_result.dart';

class SeverityQuiz extends StatefulWidget {
  @override
  State<SeverityQuiz> createState() => _SeverityQuizState();
}

class _SeverityQuizState extends State<SeverityQuiz> {
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  Answer? selectedAnswer;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text(                //this for show question number
        //   "Question ${currentQuestionIndex+1}/{questionList.length.toString()}",
        //   style: const TextStyle(
        //     color: Colors.black,
        //   ),
        // ),
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
              ? Colors.green.shade400
              : Colors.lightBlueAccent.shade700,
          onPrimary: isSelected ? Colors.black : Colors.black,
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
    bool islastQuestion = false;
    if (currentQuestionIndex == questionList.length - 1) {
      islastQuestion = true;
    }

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
            if (islastQuestion) {
              //redirect to result sheet
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ResultScreen()));
            } else {
              //next question
              setState(() {
                selectedAnswer = null;
                currentQuestionIndex++;
              });
            }
          }),
    );
  }
}


//try this for latest5
// import 'package:flutter/material.dart';
// import 'package:myalo_app/models/severity_quiz_model.dart';
// import 'package:myalo_app/function.dart'; // Import the function.dart file

// import 'severity_result.dart';

// class SeverityQuiz extends StatefulWidget {
//   @override
//   State<SeverityQuiz> createState() => _SeverityQuizState();
// }

// class _SeverityQuizState extends State<SeverityQuiz> {
//   List<Question> questionList = [];
//   int currentQuestionIndex = 0;
//   Answer? selectedAnswer;

//   @override
//   void initState() {
//     super.initState();
//     _fetchQuestions(); // Fetch questions when the component loads
//   }

//   Future<void> _fetchQuestions() async {
//     try {
//       final questionsResponse = await Functions.fetchSeverityQuestions();
//       if (questionsResponse.containsKey('questions')) {
//         final questions = questionsResponse['questions'];
//         setState(() {
//           questionList = List<Question>.from(questions.map((question) => Question.fromJson(question)));
//         });
//       }
//     } catch (e) {
//       // Handle error
//       print('Error fetching questions: $e');
//     }
//   }

//   // ... (Rest of your code remains the same)

//   _nextButton() {
//     bool isLastQuestion = false;
//     if (currentQuestionIndex == questionList.length - 1) {
//       isLastQuestion = true;
//     }

//     return Container(
//       width: MediaQuery.of(context).size.width * 0.5,
//       height: 40,
//       child: ElevatedButton(
//         child: Text(isLastQuestion ? "Show Results" : "Next"),
//         style: ElevatedButton.styleFrom(
//           shape: const StadiumBorder(),
//           primary: Colors.green.shade400,
//           onPrimary: Colors.black,
//         ),
//         onPressed: () {
//           if (isLastQuestion) {
//             // Submit answers and show results
//             _submitAnswersAndShowResults();
//           } else {
//             // Next question
//             setState(() {
//               selectedAnswer = null;
//               currentQuestionIndex++;
//             });
//           }
//         },
//       ),
//     );
//   }

//   Future<void> _submitAnswersAndShowResults() async {
//     final answers = {
//       'answers': questionList.map((question) => {'question': question.questionText, 'answer': selectedAnswer?.answerText}).toList(),
//     };

//     try {
//       final result = await Functions.submitSeverityAnswers(answers);
//       // Process the result and navigate to the result screen
//       // Example: You can extract severity level and recommendations from the result
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ResultScreen(
//             severityLevel: result['severity'],
//             recommendations: List<String>.from(result['recommendations']),
//           ),
//         ),
//       );
//     } catch (e) {
//       // Handle error
//       print('Error submitting answers and showing results: $e');
//     }
//   }
// }

class Question {
  final String questionText;
  final String illness;
  final int MID;
  final List<Answer> answerList;

  Question({
    required this.questionText,
    required this.illness,
    required this.MID,
    required this.answerList,
  });
}

class Answer {
  final int answerId;
  final String answerText;

  Answer({
    required this.answerId,
    required this.answerText,
  });
}


// class Question {
//   final String questionText;
//   final List<Answer> answerList;

//   Question(this.questionText, this.answerList);
// }

// class Answer {
//   final String answerText;
//   final bool isIdentifyFilter; //answer checkup
//   Answer(this.answerText, this.isIdentifyFilter);
// }

// List<Question> getQuestions() {
//   List<Question> list = [];

//   list.add(Question(
//     "1. Are you particularly anxious or fearful when looking down from a height, even if you are in a safe and secure environment? ",
//     [
//       Answer("Yes", true),
//       Answer("No", true),
//       Answer("Maybe", true),
//     ],
//   ));

//   list.add(Question(
//     "2.	Do you actively avoid situations or places that involve heights, such as avoiding tall buildings, amusement park rides, or hiking in elevated areas? ",
//     [
//       Answer("Yes", true),
//       Answer("No", true),
//       Answer("Maybe", true),
//     ],
//   ));

//   list.add(Question(
//     "3.	Do you experience intense anxiety or fear when you are in high places, such as tall buildings, bridges, or mountains? ",
//     [
//       Answer("Yes", true),
//       Answer("No", true),
//       Answer("Maybe", true),
//     ],
//   ));

//   list.add(Question(
//     "4.	Do you have difficulty organizing your thoughts or expressing them coherently?",
//     [
//       Answer("Yes", true),
//       Answer("No", true),
//       Answer("Maybe", true),
//     ],
//   ));

//   list.add(Question(
//     "5.	Do you often experience hallucinations, such as seeing, hearing, or feeling things that others cannot perceive?",
//     [
//       Answer("Yes", true),
//       Answer("No", true),
//       Answer("Maybe", true),
//     ],
//   ));

//   list.add(Question(
//     "6.	Do you often withdraw from social interactions, preferring to be alone?",
//     [
//       Answer("Yes", true),
//       Answer("No", true),
//       Answer("Maybe", true),
//     ],
//   ));

//   list.add(Question(
//     "7.	Do you work while being observed?",
//     [
//       Answer("Yes", true),
//       Answer("No", true),
//       Answer("Maybe", true),
//     ],
//   ));

//   list.add(Question(
//     "8.	Have you ever felt that your thoughts are being broadcasted or that others can hear your internal thoughts?",
//     [
//       Answer("Yes", true),
//       Answer("No", true),
//       Answer("Maybe", true),
//     ],
//   ));

//   list.add(Question(
//     "9.	When faced with a height-related situation, do you experience physical symptoms of anxiety, such as rapid heartbeat, trembling, sweating, or shortness of breath?",
//     [
//       Answer("Yes", true),
//       Answer("No", true),
//       Answer("Maybe", true),
//     ],
//   ));

//   return list;
// }

class Question {
  final String questionText;
  final String illness;

  final List<Answer> answerList;

  Question({
    required this.questionText,
    required this.illness,
    required this.answerList,
  });
}

class Answer {
  final int answerWeight;
  final String answerText;

  Answer({
    required this.answerWeight,
    required this.answerText,
  });
}

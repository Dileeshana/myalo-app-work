class Question {
  final String questionText;
  final List<Answer> answerList;

  Question(this.questionText, this.answerList);
}

class Answer {
  final String answerText;
  final bool isIdentifyFilter; //answer checkup

  Answer(this.answerText, this.isIdentifyFilter);
}

List<Question> getQuestions() {
  List<Question> list = [];

  list.add(Question(
    "Do you get anxious often?",
    [
      Answer("Yes", true),
      Answer("No", true),
      Answer("Maybe", true),
    ],
  ));

  list.add(Question(
    "Do you have a fear of elevators?",
    [
      Answer("Yes", true),
      Answer("No", true),
      Answer("Maybe", true),
    ],
  ));

  list.add(Question(
    "Is it difficult for you to look down from heights?",
    [
      Answer("Yes", true),
      Answer("No", true),
      Answer("Maybe", true),
    ],
  ));

  list.add(Question(
    "Do you have a fear of open spaces at heigts?",
    [
      Answer("Yes", true),
      Answer("No", true),
      Answer("Maybe", true),
    ],
  ));

  list.add(Question(
    "Do you usually avoid elevated or high places?",
    [
      Answer("Yes", true),
      Answer("No", true),
      Answer("Maybe", true),
    ],
  ));

  list.add(Question(
    "Do you have a difficulty of going up and down the stairs?",
    [
      Answer("Yes", true),
      Answer("No", true),
      Answer("Maybe", true),
    ],
  ));

  list.add(Question(
    "do you often think about falling from high places?",
    [
      Answer("Yes", true),
      Answer("No", true),
      Answer("Maybe", true),
    ],
  ));

  list.add(Question(
    "Do you have a fear of mountain cllimbing or hiking?",
    [
      Answer("Yes", true),
      Answer("No", true),
      Answer("Maybe", true),
    ],
  ));

  return list;
}

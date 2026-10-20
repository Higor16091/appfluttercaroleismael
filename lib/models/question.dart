class Question {
  final String text;

  final List<String> answers;

  final int correctAnswer;

  const Question({
    required this.text,
    required this.answers,
    required this.correctAnswer,
  });
}
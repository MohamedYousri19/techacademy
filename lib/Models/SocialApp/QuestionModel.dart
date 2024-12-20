class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswer;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
  });

  factory Question.fromFirestore(Map<String, dynamic> data) {
    return Question(
      questionText: data['questionText'] ?? '',
      options: List<String>.from(data['options'] ?? []),
      correctAnswer: data['correctAnswer'] ?? 0,
    );
  }
}
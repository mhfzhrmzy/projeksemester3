/// Simple data model for a single question.
///
/// [code] is optional — when provided, it is rendered inside a
/// monospace code block above the question text (used by Post-Test).
class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String? code;

  const Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    this.code,
  });
}

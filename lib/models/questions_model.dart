// representa cada pergunta do formulário

enum QuestionType { vulnerability, threat }

class QuestionOption {
  final String text;
  final int value; // peso da resposta

  const QuestionOption({required this.text, required this.value});
}

class Question {
  final String id;
  final String text;
  final QuestionType type;
  final List<QuestionOption> options;

  const Question({
    required this.id,
    required this.text,
    required this.type,
    required this.options,
  });
}

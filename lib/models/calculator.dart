// metodologia de calculo

import 'questions_model.dart';

enum RiskClassification {
  baixo,
  moderado,
  alto,
  muitoAlto,
}

class RiskResult {
  final int vulnerabilityScore;
  final int threatScore;
  final int totalScore;
  final RiskClassification classification;

  const RiskResult({
    required this.vulnerabilityScore,
    required this.threatScore,
    required this.totalScore,
    required this.classification,
  });

  String get classificationLabel {
    switch (classification) {
      case RiskClassification.baixo:
        return 'Baixo';
      case RiskClassification.moderado:
        return 'Moderado';
      case RiskClassification.alto:
        return 'Alto';
      case RiskClassification.muitoAlto:
        return 'Muito Alto';
    }
  }

  String get orientationMessage {
    switch (classification) {
      case RiskClassification.baixo:
        return 'Sua situação apresenta sinais de alerta. '
            'Considere buscar orientação com profissionais de apoio.';
      case RiskClassification.moderado:
        return 'Sua situação merece atenção. '
            'Recomendamos conversar com um profissional da rede de proteção.';
      case RiskClassification.alto:
        return 'Sua situação indica risco significativo. '
            'Existem recursos disponíveis para te ajudar quando você se sentir pronta.';
      case RiskClassification.muitoAlto:
        return 'Sua situação indica risco elevado. '
            'A rede de proteção está disponível para te apoiar com sigilo e cuidado.';
    }
  }
}

class RiskCalculator {
  static const int _maxScore = 5; // limite por categoria

  /// Calcula o resultado a partir de um mapa {questionId: valor selecionado}
  static RiskResult calculate(
      Map<String, int> answers,
      List<Question> questions,
      ) {
    int vulnerabilityScore = 0;
    int threatScore = 0;

    for (final question in questions) {
      final value = answers[question.id] ?? 0;

      if (question.type == QuestionType.vulnerability) {
        if (vulnerabilityScore < _maxScore) {
          vulnerabilityScore =
              (vulnerabilityScore + value).clamp(0, _maxScore * 4);
        }
      } else {
        if (threatScore < _maxScore) {
          threatScore = (threatScore + value).clamp(0, _maxScore * 4);
        }
      }
    }

    final total = vulnerabilityScore + threatScore;
    final classification = _classify(total);

    return RiskResult(
      vulnerabilityScore: vulnerabilityScore,
      threatScore: threatScore,
      totalScore: total,
      classification: classification,
    );
  }

  static RiskClassification _classify(int total) {
    if (total <= 5) return RiskClassification.baixo;
    if (total <= 15) return RiskClassification.moderado;
    if (total <= 25) return RiskClassification.alto;
    return RiskClassification.muitoAlto;
  }
}

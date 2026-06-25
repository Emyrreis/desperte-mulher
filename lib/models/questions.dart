import 'questions_model.dart';

class QuestionsData {
  static const List<Question> questions = [
    // vulnerabilidade
    Question(
      id: 'v1',
      text: 'Você depende financeiramente do(a) agressor(a)?',
      type: QuestionType.vulnerability,
      options: [
        QuestionOption(text: 'Não', value: 0),
        QuestionOption(text: 'Parcialmente', value: 2),
        QuestionOption(text: 'Sim, totalmente', value: 5),
      ],
    ),
    Question(
      id: 'v2',
      text: 'Você tem filhos com o(a) agressor(a)?',
      type: QuestionType.vulnerability,
      options: [
        QuestionOption(text: 'Não', value: 0),
        QuestionOption(text: 'Sim', value: 3),
      ],
    ),
    Question(
      id: 'v3',
      text: 'Você mora na mesma residência que o(a) agressor(a)?',
      type: QuestionType.vulnerability,
      options: [
        QuestionOption(text: 'Não', value: 0),
        QuestionOption(text: 'Sim', value: 4),
      ],
    ),
    Question(
      id: 'v4',
      text: 'Você tem apoio de familiares ou amigos próximos?',
      type: QuestionType.vulnerability,
      options: [
        QuestionOption(text: 'Sim, tenho apoio', value: 0),
        QuestionOption(text: 'Tenho pouco apoio', value: 2),
        QuestionOption(text: 'Não tenho apoio', value: 5),
      ],
    ),
    Question(
      id: 'v5',
      text: 'Você já precisou se afastar do trabalho ou estudo por causa da situação?',
      type: QuestionType.vulnerability,
      options: [
        QuestionOption(text: 'Não', value: 0),
        QuestionOption(text: 'Sim, algumas vezes', value: 2),
        QuestionOption(text: 'Sim, frequentemente', value: 5),
      ],
    ),

    // ameaca
    Question(
      id: 'a1',
      text: 'O(a) agressor(a) já fez ameaças de morte a você ou seus filhos?',
      type: QuestionType.threat,
      options: [
        QuestionOption(text: 'Não', value: 0),
        QuestionOption(text: 'Sim, verbalmente', value: 3),
        QuestionOption(text: 'Sim, com arma ou objeto', value: 5),
      ],
    ),
    Question(
      id: 'a2',
      text: 'O(a) agressor(a) possui ou tem acesso a armas de fogo?',
      type: QuestionType.threat,
      options: [
        QuestionOption(text: 'Não', value: 0),
        QuestionOption(text: 'Não sei', value: 2),
        QuestionOption(text: 'Sim', value: 5),
      ],
    ),
    Question(
      id: 'a3',
      text: 'As agressões têm aumentado em frequência ou gravidade?',
      type: QuestionType.threat,
      options: [
        QuestionOption(text: 'Não', value: 0),
        QuestionOption(text: 'Sim, levemente', value: 2),
        QuestionOption(text: 'Sim, muito', value: 5),
      ],
    ),
    Question(
      id: 'a4',
      text: 'O(a) agressor(a) faz uso de álcool ou drogas?',
      type: QuestionType.threat,
      options: [
        QuestionOption(text: 'Não', value: 0),
        QuestionOption(text: 'Ocasionalmente', value: 2),
        QuestionOption(text: 'Com frequência', value: 4),
      ],
    ),
    Question(
      id: 'a5',
      text: 'O(a) agressor(a) já descumpriu medida protetiva?',
      type: QuestionType.threat,
      options: [
        QuestionOption(text: 'Não há medida protetiva', value: 0),
        QuestionOption(text: 'Não descumpriu', value: 0),
        QuestionOption(text: 'Sim, descumpriu', value: 5),
      ],
    ),
  ];

  // pontuacao maxima
  static const int maxVulnerability = 20;
  static const int maxThreat = 19;
}

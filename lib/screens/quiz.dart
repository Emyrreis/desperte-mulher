// formulário

import 'package:flutter/material.dart';
import '../models/questions.dart';
import '../models/calculator.dart';
import '../widget/card.dart';
import '../widget/meter.dart';
import '../theme/app_theme.dart';
import 'result.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final Map<String, int> _answers = {};
  RiskResult? _partialResult;

  void _onOptionSelected(String questionId, int value) {
    setState(() {
      _answers[questionId] = value;
      _partialResult = RiskCalculator.calculate(
        _answers,
        QuestionsData.questions,
      );
    });
  }

  bool get _canProceed =>
      _answers.length == QuestionsData.questions.length;

  void _onCalculate() {
    if (!_canProceed) {
      _showIncompleteDialog();
      return;
    }

    final result = RiskCalculator.calculate(
      _answers,
      QuestionsData.questions,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(result: result),
      ),
    );
  }

  void _showIncompleteDialog() {
    final remaining = QuestionsData.questions.length - _answers.length;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Quase lá!',
          style: TextStyle(color: AppColors.primaryDark),
        ),
        content: Text(
          'Ainda faltam $remaining ${remaining == 1 ? 'pergunta' : 'perguntas'} '
              'para calcular seu resultado com precisão.',
          style: const TextStyle(color: AppColors.textSecondary, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Continuar respondendo',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questions = QuestionsData.questions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliação de Situação'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => _showExitConfirmation(),
        ),
      ),
      body: Column(
        children: [
          RiskMeterWidget(
            answeredCount: _answers.length,
            totalCount: questions.length,
            vulnerabilityScore: _partialResult?.vulnerabilityScore,
            threatScore: _partialResult?.threatScore,
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12, bottom: 120),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                return QuestionCardWidget(
                  question: question,
                  questionNumber: index + 1,
                  selectedValue: _answers[question.id],
                  onOptionSelected: (value) =>
                      _onOptionSelected(question.id, value),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: _buildCalculateButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildCalculateButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: FloatingActionButton.extended(
          onPressed: _onCalculate,
          backgroundColor:
          _canProceed ? AppColors.primary : AppColors.textHint,
          elevation: _canProceed ? 4 : 0,
          label: Text(
            _canProceed
                ? 'Ver meu resultado'
                : '${_answers.length}/${QuestionsData.questions.length} respondidas',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          icon: Icon(
            _canProceed
                ? Icons.bar_chart_rounded
                : Icons.radio_button_unchecked_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showExitConfirmation() {
    if (_answers.isEmpty) {
      Navigator.pop(context);
      return;
    }
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Sair do formulário?'),
        content: const Text(
          'Suas respostas serão perdidas. Você pode retornar quando quiser.',
          style: TextStyle(color: AppColors.textSecondary, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Continuar',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text(
              'Sair',
              style: TextStyle(color: AppColors.textHint),
            ),
          ),
        ],
      ),
    );
  }
}

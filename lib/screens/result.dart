// tela de resultado com:
// nivel de vulnerabilidade, nivel de ameaca, grau de risco, classificacao

import 'package:flutter/material.dart';
import '../models/calculator.dart';
import '../theme/app_theme.dart';
import 'welcome.dart';

class ResultScreen extends StatelessWidget {
  final RiskResult result;

  const ResultScreen({super.key, required this.result});

  Color _getRiskColor(RiskClassification c) {
    switch (c) {
      case RiskClassification.baixo:
        return AppColors.riskLow;
      case RiskClassification.moderado:
        return AppColors.riskModerate;
      case RiskClassification.alto:
        return AppColors.riskHigh;
      case RiskClassification.muitoAlto:
        return AppColors.riskVeryHigh;
    }
  }

  IconData _getRiskIcon(RiskClassification c) {
    switch (c) {
      case RiskClassification.baixo:
        return Icons.sentiment_satisfied_alt_rounded;
      case RiskClassification.moderado:
        return Icons.sentiment_neutral_rounded;
      case RiskClassification.alto:
        return Icons.sentiment_dissatisfied_rounded;
      case RiskClassification.muitoAlto:
        return Icons.warning_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final riskColor = _getRiskColor(result.classification);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu Resultado'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // card principal
            _buildClassificationCard(context, riskColor),

            const SizedBox(height: 20),

            // indicadores
            _buildIndicatorsCard(context),

            const SizedBox(height: 20),

            // mensagem de orientacao
            _buildOrientationCard(context),

            const SizedBox(height: 20),

            // opcao de denuncia
            _buildReportCard(context),

            const SizedBox(height: 32),

            // reiniciar quiz
            OutlinedButton(
              onPressed: () => _goHome(context),
              child: const Text('Voltar ao início'),
            ),

            const SizedBox(height: 16),

            Center(
              child: Text(
                'Você pode refazer o formulário a qualquer momento.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildClassificationCard(BuildContext context, Color riskColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: riskColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: riskColor.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        children: [
          Icon(
            _getRiskIcon(result.classification),
            size: 56,
            color: riskColor,
          ),
          const SizedBox(height: 12),
          Text(
            'Sua Classificação de Risco é:',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            result.classificationLabel,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: riskColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.progressBackground),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Detalhamento',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildIndicatorRow(
            context,
            label: 'Seu Nível de Vulnerabilidade é:',
            value: '${result.vulnerabilityScore}',
          ),
          const Divider(height: 24),
          _buildIndicatorRow(
            context,
            label: 'Seu Nível de Ameaça é:',
            value: '${result.threatScore}',
          ),
          const Divider(height: 24),
          _buildIndicatorRow(
            context,
            label: 'Seu Grau de Risco é:',
            value: '${result.totalScore}',
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorRow(
      BuildContext context, {
        required String label,
        required String value,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryDark,
          ),
        ),
      ],
    );
  }

  Widget _buildOrientationCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.favorite_outline_rounded,
                  color: AppColors.primary, size: 20),
              SizedBox(width: 8),
              Text(
                'Uma palavra para você',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            result.orientationMessage,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.7,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.progressBackground),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quando você se sentir pronta...',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Você pode optar por se identificar e encaminhar seu caso para '
                'a rede de proteção. Isso é uma escolha sua, tomada no seu tempo.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: navegar para tela de encaminhamento de denúncia
              },
              child: const Text('Quero prosseguir com denúncia'),
            ),
          ),
        ],
      ),
    );
  }

  void _goHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          (route) => false,
    );
  }
}

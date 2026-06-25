// medidor visual de risco em tempo real

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/calculator.dart';

class RiskMeterWidget extends StatelessWidget {
  final int answeredCount;
  final int totalCount;
  final int? vulnerabilityScore;
  final int? threatScore;

  const RiskMeterWidget({
    super.key,
    required this.answeredCount,
    required this.totalCount,
    this.vulnerabilityScore,
    this.threatScore,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalCount > 0 ? answeredCount / totalCount : 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.progressBackground, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // progresso do formulário
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progresso',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                '$answeredCount de $totalCount respondidas',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.progressBackground,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 8,
            ),
          ),

          // indicadores
          if (answeredCount >= 3) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                _buildScoreChip(
                  context,
                  label: 'Vulnerabilidade',
                  score: vulnerabilityScore ?? 0,
                ),
                const SizedBox(width: 8),
                _buildScoreChip(
                  context,
                  label: 'Ameaça',
                  score: threatScore ?? 0,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScoreChip(
      BuildContext context, {
        required String label,
        required int score,
      }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 11,
                color: AppColors.textHint,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              score.toString(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primaryDark,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

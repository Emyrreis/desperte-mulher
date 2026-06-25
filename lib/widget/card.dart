// widgets/question_card_widget.dart
// Card de perguntas

import 'package:flutter/material.dart';
import '../models/questions_model.dart';
import '../theme/app_theme.dart';

class QuestionCardWidget extends StatelessWidget {
  final Question question;
  final int questionNumber;
  final int? selectedValue;
  final ValueChanged<int> onOptionSelected;

  const QuestionCardWidget({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.selectedValue,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selectedValue != null
              ? AppColors.primaryLight.withOpacity(0.6)
              : AppColors.progressBackground,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Número e label do tipo
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '$questionNumber',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: question.type == QuestionType.vulnerability
                        ? AppColors.primaryLight.withOpacity(0.2)
                        : AppColors.secondaryLight.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    question.type == QuestionType.vulnerability
                        ? 'Vulnerabilidade'
                        : 'Ameaça',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: question.type == QuestionType.vulnerability
                          ? AppColors.primaryDark
                          : AppColors.secondary,
                    ),
                  ),
                ),
                if (selectedValue != null) ...[
                  const Spacer(),
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ],
              ],
            ),

            const SizedBox(height: 14),

            // Texto da pergunta
            Text(
              question.text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 16),

            // Opções
            ...question.options.asMap().entries.map(
                  (entry) => _buildOption(context, entry.value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, QuestionOption option) {
    final isSelected = selectedValue == option.value;

    return GestureDetector(
      onTap: () => onOptionSelected(option.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.08)
              : AppColors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.progressBackground,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textHint,
                  width: isSelected ? 5 : 2,
                ),
                color:
                isSelected ? AppColors.primary : Colors.transparent,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option.text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected
                      ? AppColors.primaryDark
                      : AppColors.textPrimary,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

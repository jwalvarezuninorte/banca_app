import 'package:banca_app/constants/app_theme.dart';
import 'package:flutter/material.dart';

class QuestionActionRow extends StatelessWidget {
  const QuestionActionRow({
    required this.questionLabel,
    required this.actionLabel,
    required this.action,
    super.key,
  });
  final String questionLabel;
  final String actionLabel;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          questionLabel,
          style: AppTheme.lightTheme.textTheme.labelMedium!.copyWith(
            color: AppTheme.dark.withOpacity(0.6),
          ),
        ),
        TextButton(
          onPressed: action,
          child: Text(
            actionLabel,
            style: AppTheme.lightTheme.textTheme.labelMedium!.copyWith(
              color: AppTheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

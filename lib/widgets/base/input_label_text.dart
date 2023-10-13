import 'package:banca_app/constants/app_theme.dart';
import 'package:flutter/material.dart';

class InputLabelText extends StatelessWidget {
  const InputLabelText(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.padding / 1.6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.dark.withOpacity(0.6),
            ),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}

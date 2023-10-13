import 'package:banca_app/constants/app_theme.dart';
import 'package:flutter/material.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({super.key, this.icon = Icons.close});

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 10,
        shadowColor: Colors.black87,
      ),
      padding: const EdgeInsets.all(AppTheme.padding / 1.5),
      onPressed: () => Navigator.of(context).pop(),
      icon: Icon(icon),
    );
  }
}

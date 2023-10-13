import 'package:banca_app/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class BancaCreditoLogoName extends StatelessWidget {
  const BancaCreditoLogoName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppTheme.padding / 2),
          child: SvgPicture.asset(
            'assets/icons/app_icon.svg',
          ),
        ),
        Text(
          'Banca créditos',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontSize: 32,
          ),
        ),
      ],
    );
  }
}

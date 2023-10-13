import 'package:banca_app/backend/models/credit.dart';
import 'package:banca_app/constants/app_theme.dart';
import 'package:banca_app/screens/home/home_screen.dart';
import 'package:banca_app/widgets/commons/amortization_table.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CreditSimulationResult extends StatelessWidget {
  const CreditSimulationResult({
    super.key,
    required this.credit,
    required this.onPrimaryPressed,
    this.onSecondaryPressed,
  });

  final Credit credit;
  final void Function() onPrimaryPressed;
  final void Function()? onSecondaryPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppTheme.padding),
        const HeadlineIconBody(
          headerText: 'Resultado de tu \nsimulador de crédito',
          bodyText:
              'Te presentamos en tu tabla de amortización el resultado del movimiento de tu crédito.',
          showIcon: false,
        ),
        const SizedBox(height: AppTheme.padding / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Table de créditos',
              style: AppTheme.lightTheme.textTheme.titleMedium,
            ),
            SvgPicture.asset(
              'assets/icons/filter_settings_icon.svg',
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: AppTheme.padding),
          height: MediaQuery.of(context).size.height * 0.45,
          child: SingleChildScrollView(
            child: AmortizationTable(credit: credit),
          ),
        ),
        const SizedBox(height: AppTheme.padding),
        ElevatedButton(
          onPressed: onPrimaryPressed,
          child: const Text('Descargar tabla'),
        ),
        const SizedBox(height: AppTheme.padding / 2),
        onSecondaryPressed == null
            ? const SizedBox()
            : ElevatedButton(
                onPressed: onSecondaryPressed,
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppTheme.primary,
                  backgroundColor: AppTheme.base,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
                    side: const BorderSide(
                      color: AppTheme.primary,
                    ),
                  ),
                ),
                child: const Text('Guardar cotización'),
              ),
        const SizedBox(height: AppTheme.padding / 2),
      ],
    );
  }
}

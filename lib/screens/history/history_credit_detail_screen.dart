import 'package:banca_app/backend/models/credit.dart';
import 'package:banca_app/constants/app_theme.dart';
import 'package:banca_app/widgets/base/base.dart';
import 'package:banca_app/widgets/commons/credit_simulation_result.dart';
import 'package:flutter/material.dart';

class HistoryCreditDetailScreen extends StatelessWidget {
  const HistoryCreditDetailScreen({
    Key? key,
    this.credit,
  }) : super(key: key);

  final Credit? credit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.padding),
          child: Column(
            children: [
              const Row(
                children: [BackIconButton(icon: Icons.arrow_back_ios_new)],
              ),
              CreditSimulationResult(
                credit: credit as Credit,
                onPrimaryPressed: () async {
                  await Credit.saveAndOpenCreditSimulationExcel(
                    context: context,
                    credit: credit as Credit,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

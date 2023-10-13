import 'package:banca_app/backend/models/credit.dart';
import 'package:banca_app/backend/services/auth_service.dart';
import 'package:banca_app/constants/app_theme.dart';
import 'package:banca_app/backend/services/sqlite_service.dart';
import 'package:banca_app/widgets/commons/credit_history_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key, required this.sqliteService})
      : super(key: key);

  final SqliteService sqliteService;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppTheme.padding),
              Text(
                'Historial de créditos',
                style: AppTheme.lightTheme.textTheme.headlineSmall,
              ),
              Text(
                'Aquí encontrarás tu historial de créditos y el registro de todas tus simulaciones.',
                style: AppTheme.lightTheme.textTheme.bodyLarge,
              ),
              const SizedBox(height: AppTheme.padding),
              FutureBuilder(
                future: sqliteService.getSavedCredits(
                  userId: authService.currentUser!.id!,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasData) {
                    final List<Credit> credits = snapshot.data as List<Credit>;
                    return credits.isEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.all(AppTheme.padding / 3),
                                child: Icon(
                                  Icons.info_outline_rounded,
                                  color: AppTheme.dark.withOpacity(0.6),
                                ),
                              ),
                              Text(
                                'No hay más datos para mostrar',
                                style:
                                    AppTheme.lightTheme.textTheme.labelMedium,
                              ),
                            ],
                          )
                        : CreditHistoryTable(credits: credits);
                  }

                  return Container();
                },
              ),
              const SizedBox(height: AppTheme.padding),
            ],
          ),
        ),
      ),
    );
  }
}

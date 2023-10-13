import 'package:banca_app/backend/services/auth_service.dart';
import 'package:banca_app/backend/services/sqlite_service.dart';
import 'package:banca_app/constants/app_theme.dart';
import 'package:banca_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SqliteService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banca Créditos',
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.initialRoute,
      theme: AppTheme.lightTheme,
    );
  }
}

import 'package:banca_app/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRoute = '/init';

  static Map<String, Widget Function(BuildContext)> routes = {
    '/init': (BuildContext context) => const VerifySavedUserScreen(),
    '/onboarding': (BuildContext context) => const OnboardingScreen(),
    '/login': (BuildContext context) => const LoginScreen(),
    '/register': (BuildContext context) => const RegisterScreen(),
    '/app': (BuildContext context) => const AppScaffold(),
    '/credit_detail': (BuildContext context) =>
        const HistoryCreditDetailScreen(),
  };
}

import 'package:banca_app/backend/models/user.dart';
import 'package:banca_app/backend/services/auth_service.dart';
import 'package:banca_app/widgets/base/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class VerifySavedUserScreen extends StatefulWidget {
  const VerifySavedUserScreen({Key? key}) : super(key: key);

  @override
  State<VerifySavedUserScreen> createState() => _VerifySavedUserScreenState();
}

class _VerifySavedUserScreenState extends State<VerifySavedUserScreen> {
  late AuthService _authService;
  late Database userDatabase;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // TODO: remove this delay
      await Future.delayed(const Duration(seconds: 2));

      _authService = Provider.of<AuthService>(context, listen: false);

      userDatabase = await _authService.createUserDatabase();

      // We get the saved user from secure storage
      const storage = FlutterSecureStorage();
      Map<String, String> savedUser = await storage.readAll();

      String userEmail = savedUser['email'] ?? '';
      String userPassword = savedUser['password'] ?? '';

      // Then, verify if user exists in database (auto login)
      final User? user = await _authService.login(
        email: userEmail,
        password: userPassword,
        saveUser: true,
      );

      if (!mounted) return;

      // if user exists, navigate to home screen
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/app', (route) => false);
      }

      // if user doesn't exist, navigate to onboarding screen
      else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/onboarding',
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LoadingIndicator(message: ''),
      ),
    );
  }
}

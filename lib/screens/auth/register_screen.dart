import 'package:banca_app/backend/models/user.dart';
import 'package:banca_app/backend/services/auth_service.dart';
import 'package:banca_app/constants/app_theme.dart';
import 'package:banca_app/widgets/base/base.dart';
import 'package:banca_app/widgets/confirm_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

TextEditingController _nameController = TextEditingController();
TextEditingController _identificationController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _buttonDisable = true;
  bool _acceptTerms = false;

  void verifyButtonDisable() {
    if (_nameController.text.isNotEmpty &&
        _identificationController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _acceptTerms) {
      _buttonDisable = false;
      setState(() {});
      return;
    }

    _buttonDisable = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -280,
            right: -620,
            child: Image.asset(
              'assets/images/logo_big_texture.png',
              width: 800,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: -100,
            left: -620,
            child: Image.asset(
              'assets/images/logo_big_texture.png',
              width: 800,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.padding),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const BancaCreditoLogoName(),
                      Text(
                        'Regístrate',
                        style: AppTheme.lightTheme.textTheme.headlineSmall,
                      ),
                      Text(
                        'Solo te tomará unos minutos.',
                        style: AppTheme.lightTheme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: AppTheme.padding / 2),
                      const InputLabelText('Nombre completo'),
                      TextFormField(
                        style: const TextStyle(fontSize: 16),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))
                        ],
                        autofocus: true,
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Escribe tu nombre',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        onChanged: (value) => verifyButtonDisable(),
                      ),
                      const InputLabelText('Identificación'),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: const TextStyle(fontSize: 16),
                        autofocus: true,
                        controller: _identificationController,
                        decoration: const InputDecoration(
                          hintText: 'Escribe tu número de identificación',
                        ),
                        onChanged: (value) => verifyButtonDisable(),
                      ),
                      const InputLabelText('Email'),
                      TextFormField(
                        style: const TextStyle(fontSize: 16),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9@.]'),
                          )
                        ],
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Tu correo electrónico',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        onChanged: (value) => verifyButtonDisable(),
                      ),
                      const InputLabelText('Contraseña'),
                      TextFormField(
                        style: const TextStyle(fontSize: 16),
                        autofocus: true,
                        obscureText: true,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          hintText: 'Contraseña',
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                        ),
                        onChanged: (value) => verifyButtonDisable(),
                      ),
                      const SizedBox(height: AppTheme.padding),
                      Row(
                        children: [
                          Checkbox(
                            fillColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor,
                            ),
                            value: _acceptTerms,
                            onChanged: (value) {
                              _acceptTerms = value!;
                              verifyButtonDisable();
                            },
                          ),
                          const SizedBox(
                            width: 300,
                            child: Text(
                              'Acepto los Términos y Condiciones y la Política de privacidad de Banca créditos',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.padding * 2),
                      ElevatedButton(
                        onPressed: _buttonDisable
                            ? null
                            : () async {
                                final User? user = await authService.register(
                                  email: _emailController.text,
                                  name: _nameController.text,
                                  identification:
                                      _identificationController.text,
                                  password: _passwordController.text,
                                );

                                if (!mounted) return;

                                if (user == null) {
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Error al registrar el usuario. Intente nuevamente.',
                                        ),
                                      ),
                                    );
                                }

                                showDialog(
                                  // barrierDismissible: false,
                                  barrierColor: Colors.white,
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      insetPadding: EdgeInsets.all(0),
                                      surfaceTintColor: Colors.white,
                                      contentPadding: EdgeInsets.all(0),
                                      content: ConfirmRegistration(),
                                    );
                                  },
                                );
                              },
                        child: const Text('Continuar'),
                      ),
                      QuestionActionRow(
                        questionLabel: '¿Ya tienes una cuenta?',
                        actionLabel: 'Iniciar sesión',
                        action: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                                '/login', (route) => false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

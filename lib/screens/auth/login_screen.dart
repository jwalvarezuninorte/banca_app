import 'package:banca_app/backend/models/user.dart';
import 'package:banca_app/backend/services/auth_service.dart';
import 'package:banca_app/constants/app_theme.dart';
import 'package:banca_app/widgets/base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _buttonDisable = true;
  bool _rememberMe = false;

  void verifyButtonDisable() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
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
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BancaCreditoLogoName(),
                      Text(
                        'Inicia sesión',
                        style: AppTheme.lightTheme.textTheme.headlineSmall,
                      ),
                      Text(
                        'Solo tomará unos minutos.',
                        style: AppTheme.lightTheme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: AppTheme.padding / 2),
                      const InputLabelText('Email o usuario'),
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
                          hintText: 'username@mail.com',
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
                            value: _rememberMe,
                            onChanged: (value) {
                              _rememberMe = value!;
                              setState(() {});
                              verifyButtonDisable();
                            },
                          ),
                          const SizedBox(
                            child: Text(
                              'Recordarme',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const Spacer(),
                          QuestionActionRow(
                            questionLabel: '',
                            actionLabel: '¿Olvide mi contraseña?',
                            action: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.padding),
                      ElevatedButton(
                        onPressed: _buttonDisable
                            ? null
                            : () async {
                                final User? user = await authService.login(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  saveUser: _rememberMe,
                                );

                                if (!mounted) return;

                                if (user != null) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/app',
                                    (route) => false,
                                  );
                                  return;
                                }

                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Usuario o contraseña incorrectos',
                                      ),
                                    ),
                                  );
                              },
                        child: const Text('Iniciar sesión'),
                      ),
                      const SizedBox(height: AppTheme.padding / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppTheme.dark.withOpacity(0.2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(AppTheme.padding / 2),
                            child: Text(
                              'O',
                              style: AppTheme.lightTheme.textTheme.labelMedium!
                                  .copyWith(
                                color: AppTheme.dark.withOpacity(0.4),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppTheme.dark.withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.padding / 2),
                      ElevatedButton.icon(
                        icon: SvgPicture.asset(
                          'assets/icons/google_logo.svg',
                          width: 24,
                          height: 24,
                        ),
                        onPressed: () {},
                        label: const Text('Ingresa con Google'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppTheme.dark,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppTheme.defaultRadius,
                            ),
                            side: const BorderSide(
                              color: Color(0xffC8D0D9),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.padding / 2),
                      ElevatedButton.icon(
                        icon: SvgPicture.asset(
                          'assets/icons/apple_logo.svg',
                          width: 24,
                          height: 24,
                        ),
                        onPressed: () {},
                        label: const Text('Ingresa con Apple'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppTheme.dark,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppTheme.defaultRadius,
                            ),
                            side: const BorderSide(
                              color: Color(0xffC8D0D9),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.padding),
                      QuestionActionRow(
                        questionLabel: '¿No tienes una cuenta?',
                        actionLabel: 'Registrate',
                        action: () =>
                            Navigator.of(context).pushNamedAndRemoveUntil(
                          '/register',
                          (route) => false,
                        ),
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

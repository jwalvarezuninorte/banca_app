import 'package:banca_app/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class ConfirmRegistration extends StatelessWidget {
  const ConfirmRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -300,
          left: -200,
          child: Image.asset(
            'assets/images/distorted_ellipse.png',
            width: 800,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppTheme.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/confirm_registration.svg',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: AppTheme.padding),
              Text(
                'Registro exitoso',
                style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: AppTheme.padding / 2),
              Text(
                'Hemos guardado tus credenciales de forma exitosa, Presiona continuar para seguir adelante.',
                style: AppTheme.lightTheme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.padding),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login',
                  (route) => false,
                ),
                child: const Text('Continuar'),
              )
            ],
          ),
        ),
      ],
    );
  }
}

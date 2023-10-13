import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:banca_app/constants/app_theme.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<Map<String, dynamic>> onboardingData = [
    {
      'title': 'Accede a créditos con un solo toque y sin complicaciones.',
      'image': 'assets/images/onboarding_1.png',
    },
    {
      'title':
          'Toma el control de tus finanzas con confianza y accede a ellas sin restricciones.',
      'image': 'assets/images/onboarding_2.png',
    },
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 6), () {
      _selectedIndex = 1;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: const AssetImage('assets/images/onboarding_1.png'),
              image: Image.asset(onboardingData[_selectedIndex]['image']).image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.9],
                    colors: [
                      Colors.transparent,
                      Colors.black87,
                    ],
                  ),
                ),
              ),
            ),
            _AnimatedPageIndicator(
              onboardingData: onboardingData,
              selectedIndex: _selectedIndex,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  FadeInUp(
                    child: Text(
                      onboardingData[_selectedIndex]['title'],
                      style: AppTheme.lightTheme.textTheme.headlineMedium!
                          .copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.padding),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                    ),
                    child: const Text('Iniciar sesión'),
                  ),
                  const SizedBox(height: AppTheme.padding / 2),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                    },
                    child: const Text('Registrarme'),
                  ),
                  const SizedBox(height: AppTheme.padding * 2),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AnimatedPageIndicator extends StatelessWidget {
  const _AnimatedPageIndicator({
    required this.onboardingData,
    required int selectedIndex,
  }) : _selectedIndex = selectedIndex;

  final List<Map<String, dynamic>> onboardingData;
  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      top: MediaQuery.of(context).padding.top + AppTheme.padding / 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.padding / 2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(
              onboardingData.length,
              (index) => Flexible(
                fit: FlexFit.loose,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppTheme.padding / 3,
                  ),
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: SlideInLeft(
                    from: MediaQuery.of(context).size.width /
                        onboardingData.length,
                    delay: Duration(seconds: index * 6),
                    duration: const Duration(milliseconds: 6000),
                    child: Container(
                      width: double.infinity,
                      color: _selectedIndex == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:banca_app/constants/app_theme.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spin(
            infinite: true,
            spins: 1,
            child: Image.asset(
              'assets/icons/loader.png',
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(height: AppTheme.padding),
          Text(
            message,
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.primary,
              fontSize: 22,
            ),
          )
        ],
      ),
    );
  }
}

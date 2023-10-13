import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color dark = Color(0xff2B2D40);
  static const Color primary = Color(0xff5428F1);
  static const Color base = Colors.white;
  static const Color green = Color(0xff2EAE44);

  // padding, margin, etc
  static const double padding = 24;
  static const double defaultRadius = 12;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    primaryColor: AppTheme.primary,
    appBarTheme: const AppBarTheme(
      color: AppTheme.base,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppTheme.dark,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: false,
      toolbarHeight: 82,
    ),
    iconTheme: const IconThemeData(
      color: AppTheme.primary,
      size: 20,
    ),
    snackBarTheme: const SnackBarThemeData(
      contentTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    primaryIconTheme: const IconThemeData(
      color: AppTheme.primary,
      size: 200,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppTheme.base,
        backgroundColor: AppTheme.primary,
        minimumSize: const Size(double.infinity, 40),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      constraints: const BoxConstraints(maxHeight: 54),
      filled: true,
      hintStyle: TextStyle(
        color: AppTheme.dark.withOpacity(0.4),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      prefixIconColor: AppTheme.dark.withOpacity(0.6),
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
        borderSide: const BorderSide(color: Color(0xffC8D0D9), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppTheme.defaultRadius),
        borderSide: BorderSide(
          color: AppTheme.primary.withOpacity(0.6),
          width: 2,
        ),
      ),
      labelStyle: TextStyle(
        color: Colors.red.withOpacity(0.4),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppTheme.base,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppTheme.base,
      selectedItemColor: AppTheme.primary,
      unselectedItemColor: AppTheme.dark.withOpacity(0.6),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      selectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: const TextStyle(
        color: AppTheme.dark,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: const TextStyle(
        color: AppTheme.dark,
        fontSize: 26,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: const TextStyle(
        color: AppTheme.dark,
        fontSize: 34,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: const TextStyle(
        color: AppTheme.dark,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      labelMedium: TextStyle(
        color: AppTheme.dark.withOpacity(0.6),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: const TextStyle(
        color: AppTheme.dark,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: const TextStyle(
        color: AppTheme.dark,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

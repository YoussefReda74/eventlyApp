import 'package:eventapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkTheme extends BaseTheme {
  @override
  Color get backgroundColor => const Color(0xff101127);

  @override
  Color get primaryColor => const Color(0xff5669FF);

  @override
  Color get textColor => const Color(0xffF4EBDC);

  @override
  ThemeData get themData => ThemeData(
        primaryColor: primaryColor,
        hintColor: backgroundColor,
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: backgroundColor,
          iconTheme: IconThemeData(
            color: primaryColor,
          ),
          titleTextStyle: TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w400
          )
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: primaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: backgroundColor,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: backgroundColor,
        ),
        textTheme: TextTheme(
          titleSmall: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          titleMedium: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          titleLarge: GoogleFonts.inter(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          headlineLarge: GoogleFonts.inter(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          headlineMedium: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          headlineSmall: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400
          ),
          prefixIconColor: textColor,
          suffixIconColor: textColor,
          labelStyle: TextStyle(
            color: textColor
        ),
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 2,
              color: primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 2,
              color: primaryColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
}

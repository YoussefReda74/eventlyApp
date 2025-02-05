import 'package:eventapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme extends BaseTheme {
  @override
  Color get backgroundColor => const Color(0xffF2FEFF);

  @override
  Color get primaryColor => const Color(0xff5669FF);

  @override
  Color get textColor => const Color(0xff1C1C1C);
  Color gray = const Color(0xFF7B7B7B);

  @override
  ThemeData get themData => ThemeData(
        primaryColor: primaryColor,
        hintColor: backgroundColor,
        scaffoldBackgroundColor: backgroundColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(
              color: backgroundColor,
              width: 4
            )
          )
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
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
          labelStyle:  TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
            color: textColor,
          ),
          errorStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400
          ),
          prefixIconColor: gray,
          suffixIconColor: gray,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: gray,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 2,
              color: gray,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 2,
              color: gray,
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: backgroundColor,
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
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}

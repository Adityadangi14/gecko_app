import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        // textTheme: const TextTheme(
        //   // Display text styles (headings)

        //   displayLarge: TextStyle(
        //     fontSize: 96.0,
        //     fontWeight: FontWeight.w100, // Light weight for headings
        //     letterSpacing: -0.05, // Subtle letter spacing for readability
        //     height: 1.15, // Adjust line height as needed
        //   ),
        //   displayMedium: TextStyle(
        //     fontSize: 60.0,
        //     fontWeight: FontWeight.w300, // Light to medium weight for headings
        //     letterSpacing: -0.04,
        //     height: 1.20,
        //   ),
        //   displaySmall: TextStyle(
        //     fontSize: 48.0,
        //     fontWeight: FontWeight.w400, // Regular weight for headings
        //     letterSpacing: -0.02,
        //     height: 1.10,
        //   ),

        //   // Headline text styles
        //   headlineLarge: TextStyle(
        //     fontSize: 34.0,
        //     fontWeight: FontWeight.w400,
        //     letterSpacing: 0.0,
        //     height: 1.10,
        //   ),
        //   headlineMedium: TextStyle(
        //     fontSize: 24.0,
        //     fontWeight: FontWeight.w500, // Medium weight for emphasis
        //     letterSpacing: 0.0,
        //     height: 1.10,
        //   ),
        //   headlineSmall: TextStyle(
        //     fontSize: 20.0,
        //     fontWeight: FontWeight.w500,
        //     letterSpacing: 0.15,
        //     height: 1.15,
        //   ),

        //   // Title text styles
        //   titleLarge: TextStyle(
        //     fontSize: 18.0,
        //     fontWeight: FontWeight.w600, // Medium to bold weight for titles
        //     letterSpacing: 0.10,
        //   ),
        //   titleMedium: TextStyle(
        //     fontSize: 16.0,
        //     fontWeight: FontWeight.w600,
        //     letterSpacing: 0.10,
        //   ),
        //   titleSmall: TextStyle(
        //     fontSize: 14.0,
        //     fontWeight: FontWeight.w500,
        //     letterSpacing: 0.10,
        //   ),

        //   // Body text styles (paragraphs)
        //   bodyLarge: TextStyle(
        //     fontSize: 16.0, // As specified in your initial prompt
        //     fontWeight: FontWeight.w400,
        //     letterSpacing: 0.50,
        //     height: 1.60, // Adjust line height as needed for readability
        //   ),
        //   bodyMedium: TextStyle(
        //     fontSize: 14.0,
        //     fontWeight: FontWeight.w400,
        //     letterSpacing: 0.25,
        //     height: 1.50,
        //   ),
        //   bodySmall: TextStyle(
        //     fontSize: 12.0,
        //     fontWeight: FontWeight.w400,
        //     letterSpacing: 0.10,
        //     height: 1.40,
        //   ),

        //   // Button text styles
        //   labelLarge: TextStyle(
        //     fontSize: 14.0,
        //     fontWeight: FontWeight.w500,
        //     letterSpacing: 1.25, // Increased letter spacing for buttons
        //   ),

        //   // Overline text styles
        //   labelSmall: TextStyle(
        //     fontSize: 10.0,
        //     fontWeight: FontWeight.w400,
        //     letterSpacing:
        //         1.50, // More pronounced letter spacing for overlining
        //   ),
        // ),
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.green[800]!,
            onPrimary: Colors.white,
            secondary: Colors.green,
            onSecondary: Colors.green,
            error: Colors.red,
            onError: Colors.red,
            background: const Color.fromARGB(255, 240, 246, 241),
            onBackground: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black),
        chipTheme: ChipThemeData(backgroundColor: Colors.green[200]));
  }

  static ThemeData darkTheme(context) {
    return ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
        chipTheme: ChipThemeData(
            backgroundColor: Colors.green[100],
            selectedColor: Colors.green,
            side: BorderSide(color: Colors.green)),
        colorScheme: ColorScheme(
          brightness: Brightness.dark, // Sets the theme to dark
          primary: Colors.green[700]!, // Slightly lighter green for contrast
          onPrimary: Colors.black, // Black text/icon on green primary
          secondary: Colors.green[300]!, // A lighter green as an accent color
          onSecondary: Colors.black, // Black text/icon on the secondary color
          error: Colors.red[400]!, // Softer red for errors in dark mode
          onError: Colors.white, // White text/icon on error color
          background:
              const Color.fromARGB(255, 18, 18, 18), // Dark gray background
          onBackground: Colors.white, // White text/icon on background
          surface: const Color.fromARGB(
              255, 28, 28, 30), // Darker gray surface color
          onSurface: Colors.white, // White text/icon on surface
        ));
  }
}

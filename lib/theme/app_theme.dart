import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central app theme. Provides `AppTheme.lightTheme` and `AppTheme.darkTheme`.
class AppTheme {
  AppTheme._();

  static const Color _primary = Color(0xFF0A73FF);
  static const Color _accent = Color(0xFF6E44FF);

  /// Light theme
  static ThemeData get lightTheme {
    final base = ThemeData.light();
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: _primary, brightness: Brightness.light),
      primaryColor: _primary,
      scaffoldBackgroundColor: Colors.grey[50],
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: _primary,
        elevation: 0,
        titleTextStyle: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        backgroundColor: Colors.white.withOpacity(0.0),
        selectedItemColor: _primary,
        unselectedItemColor: Colors.grey,
      ),

      // <-- Use CardThemeData (not CardTheme) to satisfy newer SDKs
      cardTheme: const CardThemeData(
        shape: RoundedRectangleBorder(
          // BorderRadius.circular is non-const, so don't use a const CardThemeData here
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        elevation: 2,
        color: Colors.white,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  /// Dark theme
  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: _accent, brightness: Brightness.dark),
      primaryColor: _accent,
      scaffoldBackgroundColor: const Color(0xFF081024),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(bodyColor: Colors.white),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: const Color(0xFF07111A),
        elevation: 0,
        titleTextStyle: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
      ),

      cardTheme: const CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        elevation: 2,
        color: Color(0xFF0E1117),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _accent,
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}


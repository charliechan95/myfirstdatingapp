import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color palette matching splash screen
  static const Color primary = Color(0xFFE91E63); // Deep pink from splash
  static const Color secondary = Color(0xFFF8BBD0); // Light pink from splash
  static const Color accent = Color(0xFFF48FB1); // Medium pink
  static const Color success = Color(0xFF00C853); // Green for success
  static const Color warning = Color(0xFFFFAB00); // Orange for warnings
  
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF8F9FA);
  static const Color cardBackground = Color(0xFFFAFAFA);
  static const Color border = Color(0xFFE0E0E0);
  static const Color error = Color(0xFFD32F2F);
  
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Color(0xFF999999);
  
  static const Gradient gradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient pinkGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const Gradient subtleGradient = LinearGradient(
    colors: [Color(0xFFF8F9FA), Color(0xFFE8F0FE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppColors {
  static const Color primary = AppTheme.primary;
  static const Color secondary = AppTheme.secondary;
  static const Color accent = AppTheme.accent;
  static const Color success = AppTheme.success;
  static const Color warning = AppTheme.warning;
  
  static const Color background = AppTheme.background;
  static const Color surface = AppTheme.surface;
  static const Color cardBackground = AppTheme.cardBackground;
  static const Color border = AppTheme.border;
  static const Color error = AppTheme.error;
  
  static const Color textPrimary = AppTheme.textPrimary;
  static const Color textSecondary = AppTheme.textSecondary;
  static const Color textLight = AppTheme.textLight;
}

final lightTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.surface,
    error: AppColors.error,
  ),
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    displayLarge: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
    displayMedium: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
    displaySmall: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
    headlineMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
    headlineSmall: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
    titleLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
    titleMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
    bodyLarge: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
    bodyMedium: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
    bodySmall: const TextStyle(fontSize: 12, color: AppColors.textLight),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      elevation: 0,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.cardBackground,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.border, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.border, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.error, width: 1.5),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    hintStyle: const TextStyle(color: AppColors.textLight, fontSize: 14),
  ),
  useMaterial3: true,
);

final darkTheme = ThemeData.dark().copyWith(
  // Dark theme customization if needed
);

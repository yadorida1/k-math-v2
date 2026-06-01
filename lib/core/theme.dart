import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const bg         = Color(0xFFF7FAF7);
  static const card       = Color(0xFFFFFFFF);
  static const softGreen  = Color(0xFFF0F7F1);
  static const primary    = Color(0xFF244A36);
  static const accent     = Color(0xFF7FB685);
  static const progress   = Color(0xFFB8D8BA);
  static const cream      = Color(0xFFFFF8ED);
  static const orange     = Color(0xFFF4C27A);
  static const gray       = Color(0xFF6C7C72);
  static const blue       = Color(0xFFEEF6FF);
  static const purple     = Color(0xFFF8F4FF);
  static const darkOrange = Color(0xFFD9822B);
  static const red        = Color(0xFFE05050);
  static const border     = Color(0xFFE3EFE4);
}

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      surface: AppColors.bg,
    ),
    scaffoldBackgroundColor: AppColors.bg,
    textTheme: GoogleFonts.notoSansKrTextTheme(ThemeData.light().textTheme),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bg,
      elevation: 0,
      foregroundColor: AppColors.primary,
      titleTextStyle: TextStyle(
        fontFamily: 'Noto Sans KR',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 0,
      indicatorColor: AppColors.softGreen,
      labelTextStyle: WidgetStateProperty.resolveWith((states) => TextStyle(
        fontFamily: 'Noto Sans KR',
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: states.contains(WidgetState.selected)
            ? AppColors.primary
            : AppColors.gray,
      )),
      iconTheme: WidgetStateProperty.resolveWith((states) => IconThemeData(
        color: states.contains(WidgetState.selected)
            ? AppColors.primary
            : AppColors.gray,
      )),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle: const TextStyle(
          fontFamily: 'Noto Sans KR',
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

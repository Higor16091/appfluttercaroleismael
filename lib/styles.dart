import 'package:flutter/material.dart';

/// Identidade visual do Meu Saber.
class AppColors {
  static const Color blue = Color(0xFF2864F0);
  static const Color purple = Color(0xFF7255E8);
  static const Color navy = Color(0xFF17233D);
  static const Color text = Color(0xFF26334A);
  static const Color muted = Color(0xFF758198);

  static const Color background = Color(0xFFF6F8FE);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color blueLight = Color(0xFFEAF0FF);
  static const Color purpleLight = Color(0xFFF0ECFF);
  static const Color border = Color(0xFFE4E9F3);

  static const Color red = Color(0xFFE95767);
  static const Color green = Color(0xFF159A72);
  static const Color orange = Color(0xFFEA8A2F);
  static const Color yellow = Color(0xFFFFC857);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [blue, purple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const double radiusSmall = 12;
  static const double radiusMedium = 16;
  static const double radiusLarge = 22;
}

/// Compatibilidade com o código antigo.
class AppColor {
  static const Color blue = AppColors.blue;
  static const Color purple = AppColors.purple;
  static const Color navy = AppColors.navy;
  static const Color text = AppColors.text;
  static const Color muted = AppColors.muted;
  static const Color background = AppColors.background;
  static const Color surface = AppColors.surface;
  static const Color blueLight = AppColors.blueLight;
  static const Color purpleLight = AppColors.purpleLight;
  static const Color border = AppColors.border;
  static const Color red = AppColors.red;
  static const Color green = AppColors.green;
  static const Color orange = AppColors.orange;
  static const Color yellow = AppColors.yellow;


  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Roboto',

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.blue,
      primary: AppColors.blue,
      secondary: AppColors.purple,
      surface: AppColors.surface,
      error: AppColors.red,
      brightness: Brightness.light,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.navy,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: AppColors.navy,
        fontSize: 22,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppColors.radiusLarge,
        ),
        side: const BorderSide(color: AppColors.border),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 17,
      ),
      hintStyle: const TextStyle(
        color: AppColors.muted,
        fontSize: 14,
      ),
      labelStyle: const TextStyle(
        color: AppColors.muted,
        fontSize: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppColors.radiusMedium,
        ),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppColors.radiusMedium,
        ),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppColors.radiusMedium,
        ),
        borderSide: const BorderSide(
          color: AppColors.blue,
          width: 1.8,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppColors.radiusMedium,
        ),
        borderSide: const BorderSide(color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppColors.radiusMedium,
        ),
        borderSide: const BorderSide(
          color: AppColors.red,
          width: 1.8,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blue,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.border,
        disabledForegroundColor: AppColors.muted,
        elevation: 0,
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppColors.radiusMedium,
          ),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.navy,
        minimumSize: const Size(0, 50),
        side: const BorderSide(color: AppColors.border),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppColors.radiusMedium,
          ),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.blue,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppColors.radiusSmall,
          ),
        ),
      ),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>(
            (states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.blue;
          }
          return null;
        },
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.blue,
      linearTrackColor: AppColors.blueLight,
      circularTrackColor: AppColors.blueLight,
      linearMinHeight: 7,
    ),

    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.navy,
      contentTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 13,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppColors.radiusMedium,
        ),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
      space: 24,
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SplashScreen/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pokemon App',
      theme: FlexThemeData.light(
        scheme: FlexScheme.aquaBlue,
        surfaceMode: FlexSurfaceMode.highScaffoldLevelSurface,
        blendLevel: 40,
        appBarOpacity: 0.99,
        swapColors: true,
        tooltipsMatchBackground: true,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 40,
          cardRadius: 17.0,
        ),
        useMaterial3ErrorColors: true,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        fontFamily: GoogleFonts.mukta().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        colors: FlexColor.schemes[FlexScheme.aquaBlue]!.light.defaultError
            .toDark(7, true),
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        appBarStyle: FlexAppBarStyle.background,
        appBarOpacity: 0.90,
        swapColors: true,
        tooltipsMatchBackground: true,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 30,
          cardRadius: 17.0,
        ),
        useMaterial3ErrorColors: true,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        fontFamily: GoogleFonts.mukta().fontFamily,
      ),
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
      themeMode: ThemeMode.system,

      home: const SplashScreen(),
    );
  }
}

ThemeMode dark = ThemeMode.dark;
ThemeMode light = ThemeMode.light;

const button = Color(0xFF35A0CB);

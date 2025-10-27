import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';



/// SchemeColors
const colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: firstColor,        // ✅ Verde para elementos principales
  onPrimary: whiteColor,      // ✅ Blanco sobre verde
  secondary: secondColor,     // ✅ Gris oscuro para secundarios
  onSecondary: whiteColor,    // ✅ Blanco sobre gris oscuro
  error: redColor,           // ✅ Rojo para errores
  onError: whiteColor,        // ✅ Blanco sobre rojo
  surface: whiteColor,        // ✅ Fondo blanco
  onSurface: secondColor,     // ✅ Texto gris oscuro sobre blanco
);

const bottomNavigationBarTheme = BottomNavigationBarThemeData(
  backgroundColor: Colors.white,
  elevation: 0,
);


const cupertinoOverrideTheme = CupertinoThemeData(
  primaryColor: firstColor,        // ✅ Verde consistente con el tema
  textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(letterSpacing: 0),
  ),
);

const appBarTheme = AppBarTheme(
  backgroundColor: whiteColor,
  elevation: 0,
  centerTitle: true,
);



final appTheme = ThemeData(
  //canvasColor: Colors.transparent,
  primaryColor: firstColor,        // ✅ Verde como color primario
  scaffoldBackgroundColor: whiteColor,
  textTheme: GoogleFonts.latoTextTheme(),
  cupertinoOverrideTheme: cupertinoOverrideTheme,
  bottomNavigationBarTheme: bottomNavigationBarTheme,
  appBarTheme: appBarTheme,
  useMaterial3: false,
  colorScheme: colorScheme,         // ✅ Usar el ColorScheme corregido
);
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shell_mfe_flutter/core/theme/colors.dart';

/// Clase para centralizar y organizar los estilos de texto de la aplicación.
/// Sistema unificado con un solo método que recibe parámetros
class AppTextStyles {
  AppTextStyles._(); // Constructor privado para prevenir instanciación

  // Pesos de fuente comúnmente utilizados
  static const FontWeight _weightNormal = FontWeight.normal;
  static const FontWeight _weightMedium = FontWeight.w500;
  static const FontWeight _weightSemiBold = FontWeight.w600;
  static const FontWeight _weightBold = FontWeight.bold;

  // Mapeo de tallas a tamaños de fuente
  static const Map<String, double> _sizeMap = {
    'xs': 12,
    's': 13,
    'm': 15,
    'l': 17,
    'xl': 20,
    'xxl': 24,
    'xxxl': 28,
  };

  // Mapeo de pesos de fuente
  static const Map<String, FontWeight> _weightMap = {
    'normal': _weightNormal,
    'medium': _weightMedium,
    'semiBold': _weightSemiBold,
    'bold': _weightBold,
  };

  /// Método principal para crear estilos de texto
  /// 
  /// Ejemplos de uso:
  /// - AppTextStyles.textStyle(size: 'm', color: Colors.black)
  /// - AppTextStyles.textStyle(size: 'xl', color: firstColor, weight: 'bold')
  /// - AppTextStyles.textStyle(size: 'l', color: whiteColor, weight: 'semiBold', decoration: TextDecoration.underline)
  static TextStyle textStyle({
    required String size,
    Color? color,
    String weight = 'normal',
    TextDecoration? decoration,
  }) {
    final fontSize = _sizeMap[size] ?? _sizeMap['m']!;
    final fontWeight = _weightMap[weight] ?? _weightNormal;

    return GoogleFonts.lato(
      color: color??secondColor,
      fontSize: Adaptive.sp(fontSize),
      fontWeight: fontWeight,
      decoration: decoration,
    );
  }

  // MÉTODOS DE CONVENIENCIA PARA CASOS COMUNES
  
  /// Estilo para campos de entrada de texto
  static TextStyle get input => textStyle(
    size: 'l',
    color: secondColor,
    weight: 'medium',
  );

  /// Estilo para texto en botones con fondo de color
  static TextStyle get buttonPrimary => textStyle(
    size: 'l',
    color: whiteColor,
    weight: 'semiBold',
  );

  // MÉTODOS DE UTILIDAD PARA COLORES PREDEFINIDOS
  
  /// Crea un estilo con color primario
  static TextStyle primary({
    required String size,
    String weight = 'bold',
  }) => textStyle(size: size, color: firstColor, weight: weight);

  /// Crea un estilo con color blanco
  static TextStyle white({
    required String size,
    String weight = 'semiBold',
  }) => textStyle(size: size, color: whiteColor, weight: weight);

  /// Crea un estilo con color gris
  static TextStyle gray({
    required String size,
    String weight = 'bold',
  }) => textStyle(size: size, color: grayColor, weight: weight);

  /// Crea un estilo con color verde
  static TextStyle green({
    required String size,
    String weight = 'bold',
  }) => textStyle(size: size, color: greenColor, weight: weight);

  /// Crea un estilo con color rojo (para errores)
  static TextStyle error({
    required String size,
    String weight = 'bold',
  }) => textStyle(size: size, color: redColor, weight: weight);

  /// Crea un estilo con subrayado
  static TextStyle underlined({
    required String size,
    required Color color,
    String weight = 'normal',
  }) => textStyle(
    size: size,
    color: color,
    weight: weight,
    decoration: TextDecoration.underline,
  );
}

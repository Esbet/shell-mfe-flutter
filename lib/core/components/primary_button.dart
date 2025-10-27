import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shell_mfe_flutter/core/theme/colors.dart';

/// Un botón primario personalizado con estilos consistentes para la aplicación.
///
/// Este botón está diseñado para ser el botón principal de acción en la aplicación,
/// utilizando los colores primarios y una apariencia elevada.
class PrimaryButton extends StatelessWidget {
  /// Crea un botón primario personalizado.
  ///
  /// [onPressed] es la función que se ejecuta cuando se presiona el botón.
  /// [child] es el widget que se muestra dentro del botón.
  /// [height] altura opcional del botón (por defecto 6.h).
  /// [width] ancho opcional del botón (por defecto expandido).
  /// [padding] espaciado externo del botón.
  /// [borderRadius] radio de borde del botón.
  /// [backgroundColor] color de fondo del botón cuando está habilitado.
  /// [disabledBackgroundColor] color de fondo cuando está deshabilitado.
  /// [elevation] elevación del botón.
  /// [loading] si se debe mostrar un indicador de carga en lugar del child.
  /// [loadingColor] color del indicador de carga.
  /// [splashColor] color del efecto splash al presionar.
  const PrimaryButton({
    super.key,
    this.onPressed,
    this.child,
    this.height,
    this.width,
    this.padding,
    this.borderRadius = 20.0,
    this.backgroundColor = firstColor,
    this.disabledBackgroundColor = disableButtonColor,
    this.elevation = 2.0,
    this.loading = false,
    this.loadingColor = Colors.white,
    this.splashColor,
    this.fullWidth = true,
    this.margin,
  });

  /// Función que se ejecuta cuando se presiona el botón.
  final VoidCallback? onPressed;

  /// Widget que se muestra dentro del botón.
  final Widget? child;

  /// Altura opcional del botón.
  final double? height;

  /// Ancho opcional del botón.
  final double? width;

  /// Espaciado externo del botón.
  final EdgeInsetsGeometry? padding;

  /// Radio de borde del botón.
  final double borderRadius;

  /// Color de fondo del botón cuando está habilitado.
  final Color backgroundColor;

  /// Color de fondo cuando está deshabilitado.
  final Color disabledBackgroundColor;

  /// Elevación del botón.
  final double elevation;

  /// Si se debe mostrar un indicador de carga en lugar del child.
  final bool loading;

  /// Color del indicador de carga.
  final Color loadingColor;

  /// Color del efecto splash al presionar.
  final Color? splashColor;

  /// Si el botón debe ocupar todo el ancho disponible.
  final bool fullWidth;

  /// Márgenes personalizados para el botón.
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final buttonContent =
        loading
            ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
              ),
            )
            : child;

    final button = ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        backgroundColor: backgroundColor,
        disabledBackgroundColor: disabledBackgroundColor,
        elevation: elevation,
        padding:
            padding ?? EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
        // Material 3 properties
        foregroundColor: Colors.white,
      ),
      child: buttonContent,
    );

    final buttonWithSize = SizedBox(
      height: height ?? 6.h,
      width: fullWidth ? null : width,
      child: button,
    );

    return Padding(
      padding: margin ?? EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
      child:
          fullWidth
              ? Row(children: [Expanded(child: buttonWithSize)])
              : buttonWithSize,
    );
  }

  /// Crea un botón primario con texto.
  ///
  /// Es una forma conveniente de crear un botón primario con un texto como hijo.
  ///
  /// [text] es el texto que se mostrará en el botón.
  /// [textStyle] es el estilo de texto opcional.
  factory PrimaryButton.text({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    TextStyle? textStyle,
    double? height,
    double? width,
    EdgeInsetsGeometry? padding,
    double borderRadius = 20.0,
    Color backgroundColor = firstColor,
    Color disabledBackgroundColor = disableButtonColor,
    double elevation = 2.0,
    bool loading = false,
    Color loadingColor = Colors.white,
    Color? splashColor,
    bool fullWidth = true,
    EdgeInsetsGeometry? margin,
  }) {
    return PrimaryButton(
      key: key,
      onPressed: onPressed,
      height: height,
      width: width,
      padding: padding,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      elevation: elevation,
      loading: loading,
      loadingColor: loadingColor,
      splashColor: splashColor,
      fullWidth: fullWidth,
      margin: margin,
      child: Text(
        text,
        style:
            textStyle ??
            const TextStyle(
              color: secondColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
      ),
    );
  }

  /// Crea un botón primario con un icono y texto.
  ///
  /// Es una forma conveniente de crear un botón primario con un icono y un texto.
  ///
  /// [text] es el texto que se mostrará en el botón.
  /// [icon] es el icono que se mostrará junto al texto.
  factory PrimaryButton.icon({
    Key? key,
    required String text,
    required IconData icon,
    VoidCallback? onPressed,
    TextStyle? textStyle,
    double? height,
    double? width,
    EdgeInsetsGeometry? padding,
    double borderRadius = 20.0,
    Color backgroundColor = firstColor,
    Color disabledBackgroundColor = disableButtonColor,
    double elevation = 2.0,
    bool loading = false,
    Color loadingColor = Colors.white,
    Color? splashColor,
    bool fullWidth = true,
    EdgeInsetsGeometry? margin,
    double spacing = 8.0,
    Color iconColor = Colors.white,
    double iconSize = 20.0,
  }) {
    return PrimaryButton(
      key: key,
      onPressed: onPressed,
      height: height,
      width: width,
      padding: padding,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      elevation: elevation,
      loading: loading,
      loadingColor: loadingColor,
      splashColor: splashColor,
      fullWidth: fullWidth,
      margin: margin,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: iconSize),
          SizedBox(width: spacing),
          Text(
            text,
            style:
                textStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}

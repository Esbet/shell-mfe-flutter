import 'package:flutter/material.dart';
import 'package:shell_mfe_flutter/core/theme/colors.dart';
import 'package:shell_mfe_flutter/core/theme/fonts.dart';


/// Crea un AppBar personalizado con estilo consistente para la aplicación.
///
/// [context] Contexto de construcción requerido para la navegación.
/// [title] Título que se mostrará en el AppBar.
/// [customBackRoute] Ruta personalizada para la navegación de retroceso (opcional).
/// [showBackButton] Determina si se muestra el botón de retroceso (por defecto true).
/// [actions] Lista de widgets para mostrar en el lado derecho del AppBar (opcional).
/// [centerTitle] Determina si el título debe centrarse (por defecto true).
/// [elevation] Elevación del AppBar (por defecto 0).
/// [backgroundColor] Color de fondo del AppBar (por defecto blanco).
/// [titleStyle] Estilo del texto del título (opcional).
/// [onBackPressed] Función personalizada para manejar la acción de retroceso (opcional).
/// [bottom] Widget para mostrar debajo del AppBar (opcional).
/// [titleSpacing] Espaciado del título (opcional).
/// [leadingWidth] Ancho del widget leading (opcional).
PreferredSizeWidget createAppBar({
  required BuildContext context,
  required String title,
  String? customBackRoute,
  bool showBackButton = true,
  List<Widget>? actions,
  bool centerTitle = true,
  double elevation = 0,
  Color backgroundColor = Colors.white,
  TextStyle? titleStyle,
  VoidCallback? onBackPressed,
  PreferredSizeWidget? bottom,
  double? titleSpacing,
  double? leadingWidth,
}) {
  return AppBar(
    leading:
        showBackButton
            ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed:
                  onBackPressed ??
                  () {
                    // Cerrar teclado primero para evitar errores de UI
                    FocusScope.of(context).unfocus();

                    if (customBackRoute != null) {
                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil(customBackRoute, (route) => false);
                    } else if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                  },
              color: grayColor,
            )
            : null,
    automaticallyImplyLeading: showBackButton,
    title: Text(title, style: titleStyle ?? AppTextStyles.textStyle(size: 'l', weight: 'semiBold')),
    backgroundColor: backgroundColor,
    elevation: elevation,
    centerTitle: centerTitle,
    actions: actions,
    bottom: bottom,
    titleSpacing: titleSpacing,
    leadingWidth: leadingWidth,
    shadowColor: Colors.black26,
  );
}

/// Versión simple del AppBar con configuración mínima.
///
/// Esta función mantiene compatibilidad con el código existente.
/// [context] Contexto de construcción requerido para la navegación.
/// [message] Título que se mostrará en el AppBar.
/// [back] Ruta personalizada para la navegación de retroceso (opcional).
PreferredSizeWidget simpleAppBar(
  BuildContext context,
  String message,
  String? back,
) {
  return createAppBar(
    context: context,
    title: message,
    customBackRoute: back,
    showBackButton: true,
  );
}

/// Crea un AppBar personalizado con acciones adicionales.
///
/// [context] Contexto de construcción requerido para la navegación.
/// [title] Título que se mostrará en el AppBar.
/// [actions] Lista de widgets para mostrar en el lado derecho del AppBar.
PreferredSizeWidget appBarWithActions(
  BuildContext context,
  String title,
  List<Widget> actions,
) {
  return createAppBar(context: context, title: title, actions: actions);
}

/// Crea un AppBar transparente con botón de retroceso.
///
/// Útil para pantallas con fondos personalizados o imágenes.
/// [context] Contexto de construcción requerido para la navegación.
/// [title] Título opcional que se mostrará en el AppBar.
/// [iconColor] Color del icono de retroceso (por defecto blanco).
PreferredSizeWidget transparentAppBar(
  BuildContext context, {
  String? title,
  Color iconColor = Colors.white,
}) {
  return createAppBar(
    context: context,
    title: title ?? '',
    backgroundColor: Colors.transparent,
    titleStyle:
        title != null
            ? TextStyle(color: iconColor, fontWeight: FontWeight.w600)
            : null,
    actions: null,
  );
}

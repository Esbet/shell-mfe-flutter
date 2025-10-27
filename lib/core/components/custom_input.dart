import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shell_mfe_flutter/core/theme/colors.dart';

/// Un widget de entrada de texto personalizado con soporte para varios casos de uso.
///
/// Este componente proporciona una entrada de texto con estilo consistente que
/// incluye soporte para etiquetas, iconos, mensajes de error y restricciones de entrada.
class CustomInput extends StatelessWidget {
  /// Crea un campo de entrada personalizado.
  ///
  /// El [placeholder] es obligatorio y define el texto de sugerencia.
  /// [obscureText] controla si el texto debe ocultarse (para contraseñas).
  const CustomInput({
    super.key,
    required this.placeholder,
    this.obscureText = false,
    this.label,
    this.errorText,
    this.textController,
    this.onChanged,
    this.icon,
    this.onIconPressed,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.enabled = true,
    this.autofocus = false,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.contentPadding,
    this.borderRadius = 10.0,
    this.textStyle,
    this.labelStyle,
    this.errorStyle,
    this.hintStyle,
    this.borderColor,
    this.focusedBorderColor,
    this.fillColor,
    this.iconColor, 
    this.prefixIcon,
  });

  /// Texto sugerido que aparece cuando el campo está vacío.
  final String placeholder;

  /// Etiqueta opcional que aparece encima del campo.
  final String? label;

  /// Texto de error que aparece debajo del campo.
  final String? errorText;

  /// Controlador para manejar el texto del campo.
  final TextEditingController? textController;

  /// Función llamada cuando cambia el texto del campo.
  final void Function(String value)? onChanged;
    /// Icono que aparece al inicio del campo.
  final IconData? prefixIcon;

  /// Icono que aparece al final del campo.
  final IconData? icon;

  /// Indica si el texto debe ocultarse (útil para contraseñas).
  final bool obscureText;

  /// Función llamada al presionar el icono.
  final VoidCallback? onIconPressed;

  /// Tipo de teclado a mostrar.
  final TextInputType? keyboardType;

  /// Cómo debe capitalizarse el texto.
  final TextCapitalization textCapitalization;

  /// Número máximo de líneas para el campo.
  final int maxLines;

  /// Número mínimo de líneas para el campo.
  final int? minLines;

  /// Longitud máxima de texto permitida.
  final int? maxLength;

  /// Formateadores para restringir o formatear el texto ingresado.
  final List<TextInputFormatter>? inputFormatters;

  /// Si el campo está habilitado para edición.
  final bool enabled;

  /// Si el campo debe enfocarse automáticamente al mostrarse.
  final bool autofocus;

  /// Acción a realizar cuando se presiona la tecla de acción del teclado.
  final TextInputAction? textInputAction;

  /// Función llamada cuando se envía el formulario.
  final Function(String)? onSubmitted;

  /// Nodo de enfoque para controlar el foco del campo.
  final FocusNode? focusNode;

  /// Alineación del texto dentro del campo.
  final TextAlign textAlign;

  /// Espaciado interior del campo de texto.
  final EdgeInsetsGeometry? contentPadding;

  /// Radio de borde del campo.
  final double borderRadius;

  /// Estilo del texto ingresado.
  final TextStyle? textStyle;

  /// Estilo de la etiqueta.
  final TextStyle? labelStyle;

  /// Estilo del texto de error.
  final TextStyle? errorStyle;

  /// Estilo del texto sugerido.
  final TextStyle? hintStyle;

  /// Color del borde del campo.
  final Color? borderColor;

  /// Color del borde cuando el campo está enfocado.
  final Color? focusedBorderColor;

  /// Color de fondo del campo.
  final Color? fillColor;

  /// Color del icono.
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    // Valores predeterminados
    final defaultBorderColor = borderColor ?? outlineColor;
    final defaultFocusedBorderColor =
        focusedBorderColor ?? Theme.of(context).primaryColor;
    final defaultFillColor = fillColor ?? outlineGrayColor;
    final defaultIconColor = iconColor ?? Colors.grey;
    final defaultHintStyle = hintStyle ?? TextStyle(color: Colors.grey);
    final defaultErrorStyle =
        errorStyle ?? TextStyle(color: Colors.red, fontSize: 12);

    return Padding(
      padding: EdgeInsets.symmetric( vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Añadir etiqueta si se proporciona
          if (label != null && label!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                label!,
                style: labelStyle ?? Theme.of(context).textTheme.bodyMedium,
              ),
            ),

          // Campo de texto principal
          TextField(
            controller: textController,
            onChanged: onChanged,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            maxLines: obscureText ? 1 : maxLines,
            minLines: minLines,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            enabled: enabled,
            autofocus: autofocus,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            focusNode: focusNode,
            textAlign: textAlign,
            style: textStyle,
            decoration: InputDecoration(
              prefixIcon: prefixIcon !=null ?Icon(prefixIcon, color: defaultIconColor,):null ,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: defaultBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: defaultFocusedBorderColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
              suffixIcon:
                  icon != null
                      ? IconButton(
                        icon: Icon(icon, color: defaultIconColor),
                        onPressed: onIconPressed,
                      )
                      : null,
              hintText: placeholder,
              hintStyle: defaultHintStyle,
              filled: true,
              fillColor: defaultFillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              counterText: "", // Oculta el contador de caracteres
            ),
          ),

          // Mensaje de error si existe
          if (errorText != null && errorText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4.0),
              child: Text(
                errorText!,
                style: defaultErrorStyle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}

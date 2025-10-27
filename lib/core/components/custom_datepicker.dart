import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import 'package:shell_mfe_flutter/core/theme/colors.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.placeholder,
    this.label,
    this.errorText,
    this.onDateSelected,
    this.initialDate,
    this.firstDate,
    this.lastDate,
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
    this.suffixIcon,
  });

  final String placeholder;
  final String? label;
  final String? errorText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime)? onDateSelected;

  final double borderRadius;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;
  final TextStyle? hintStyle;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? fillColor;
  final Color? iconColor;

  final IconData? prefixIcon; // ahora opcional
  final IconData? suffixIcon; // ahora opcional

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? selectedDate;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? selectedDate ?? now,
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultBorderColor = widget.borderColor ?? outlineColor;
    final defaultFocusedBorderColor =
        widget.focusedBorderColor ?? Theme.of(context).primaryColor;
    final defaultFillColor = widget.fillColor ?? outlineGrayColor;
    final defaultIconColor = widget.iconColor ?? Colors.grey;
    final defaultHintStyle = widget.hintStyle ?? TextStyle(color: Colors.grey);
    final defaultErrorStyle =
        widget.errorStyle ?? TextStyle(color: Colors.red, fontSize: 12);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null && widget.label!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                widget.label!,
                style:
                    widget.labelStyle ?? Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          GestureDetector(
            onTap: _pickDate,
            child: AbsorbPointer(
              child: TextField(
                controller: TextEditingController(
                  text: selectedDate != null
                      ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                      : "",
                ),
                style: widget.textStyle,
                decoration: InputDecoration(
                  prefixIcon: widget.prefixIcon != null
                      ? Icon(widget.prefixIcon, color: defaultIconColor)
                      : null,
                  suffixIcon: widget.suffixIcon != null
                      ? Icon(widget.suffixIcon, color: defaultIconColor)
                      : null,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(color: defaultBorderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: defaultFocusedBorderColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  hintText: widget.placeholder,
                  hintStyle: defaultHintStyle,
                  filled: true,
                  fillColor: defaultFillColor,
                  counterText: "",
                ),
              ),
            ),
          ),
          if (widget.errorText != null && widget.errorText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4.0),
              child: Text(
                widget.errorText!,
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

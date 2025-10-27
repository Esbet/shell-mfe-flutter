import 'package:flutter/material.dart';
import 'package:shell_mfe_flutter/core/theme/colors.dart';

class SimpleLoadingWidget extends StatelessWidget {
  final double strokeWidth;

  const SimpleLoadingWidget({
    super.key,
    this.strokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: firstColor,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
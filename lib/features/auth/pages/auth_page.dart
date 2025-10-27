import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shell_mfe_flutter/core/components/custom_input.dart';
import 'package:shell_mfe_flutter/core/theme/colors.dart';
import 'package:shell_mfe_flutter/core/theme/fonts.dart';
import 'package:shell_mfe_flutter/core/utils/resource_icons.dart';

import '../../../core/components/primary_button.dart';
import '../../register/pages/register_step1_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  static const routeName = "/auth";

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
          child: Column(
            children: [
              Image.asset(flypassLogo),
              CustomInput(placeholder: "Email", onChanged: (value) {}),
              CustomInput(placeholder: "Password", onChanged: (value) {}),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegisterStep1Page.routeName);
                },
                child: Text(
                  "¿Eres nuevo? Registrate",
                  style: AppTextStyles.textStyle(size: 'l', weight: 'bold'),
                ),
              ),
              PrimaryButton.text(text: "Login", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

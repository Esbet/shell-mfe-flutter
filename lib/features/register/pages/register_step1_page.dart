import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shell_mfe_flutter/core/components/simple_appbar.dart';
import 'package:shell_mfe_flutter/core/utils/constants.dart';
import 'package:shell_mfe_flutter/core/widget/inapp_webview_widget.dart';
import 'package:shell_mfe_flutter/features/auth/pages/auth_page.dart';

import '../../../core/theme/colors.dart';

class RegisterStep1Page extends StatefulWidget {
  const RegisterStep1Page({super.key});

  static const routeName = "/register-step1";

  @override
  State<RegisterStep1Page> createState() => _RegisterStep1PageState();
}

class _RegisterStep1PageState extends State<RegisterStep1Page> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: simpleAppBar(context, "Registro", null),
      body: SafeArea(
        child: Column(
          children: [
            InappWebviewWidget(
              url: Constants.registerStep1Url,
              pageToRedirect: AuthPage.routeName,
              onCookiesRetrieved:(cookies) {
                
              },
              onCameraAccessRequested: (requestData) {
                log('📷 Solicitud de acceso a cámara: $requestData');
                // Aquí puedes manejar la solicitud adicional si es necesario
              },
            ),
          ],
        ),
      ),
    );
  }
}
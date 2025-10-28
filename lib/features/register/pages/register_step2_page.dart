import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shell_mfe_flutter/core/components/simple_appbar.dart';
import 'package:shell_mfe_flutter/core/theme/colors.dart';
import 'package:shell_mfe_flutter/features/auth/pages/auth_page.dart';

import '../../../core/utils/constants.dart';
import '../../../core/widget/inapp_webview_widget.dart';

class Registerstep2Page extends StatefulWidget {
  const Registerstep2Page({super.key});
  static const routeName = "/register-step2";

  @override
  State<Registerstep2Page> createState() => _Registerstep2PageState();
}

class _Registerstep2PageState extends State<Registerstep2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: simpleAppBar(context, "Registro", null),
      body: SafeArea(
        child: Column(
          children: [
            InappWebviewWidget(
              url: Constants.registerStep2Url,
              pageToRedirect: AuthPage.routeName,
              onCookiesRetrieved:(cookies) {
                
              },
            ),
          ],
        ),
      ),
    );
  }
}
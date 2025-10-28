import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shell_mfe_flutter/core/components/simple_appbar.dart';
import 'package:shell_mfe_flutter/core/utils/constants.dart';
import 'package:shell_mfe_flutter/core/widget/inapp_webview_widget.dart';
import 'package:shell_mfe_flutter/features/auth/pages/auth_page.dart';
import 'package:shell_mfe_flutter/features/register/pages/register_step2_page.dart';

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
              onCookiesRetrieved: (cookies) {},
              onJsAlert: (message) async {
              final messageData = jsonDecode(message);

                if (messageData is Map<String, dynamic>) {
                  final action = messageData['action'];
                  if (action == 'REQUEST_CAMERA_ACCESS') {
                    // Procesar la solicitud de cámara
                    await _handleCameraAccessRequest();
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCameraAccessRequest() async {
    try {
      // Verificar estado actual de permisos
      final currentStatus = await Permission.camera.status;

      if (currentStatus.isGranted) {
        // Abrir cámara directamente

        await _openDocumentScanner();
      }
    } catch (e) {
      // Error al manejar solicitud de cámara
    }
  }

  /// Abrir escáner de documentos
  Future<void> _openDocumentScanner() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 80,
      );

      if (image != null) {
        _processCapturedImage(image);
      }
    } catch (e) {
      // Error al capturar imagen
    }
  }

  /// Procesar imagen capturada
  void _processCapturedImage(XFile image) {
    log('Imagen capturada: $image');
    Navigator.pushNamed(context, Registerstep2Page.routeName);
  }
}

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'main_common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Solicitar permisos de notificaciones y cámara de forma secuencial
  await _requestPermissions();
  
  runApp(const MainCommon());
}

Future<void> _requestPermissions() async {
  try {
    // Verificar qué permisos necesitan ser solicitados
    final permissionsToRequest = <Permission>[];
    
    // Verificar permisos de notificaciones
    final notificationStatus = await Permission.notification.status;
    if (notificationStatus.isDenied) {
      permissionsToRequest.add(Permission.notification);
    }
    
    // Verificar permisos de cámara
    final cameraStatus = await Permission.camera.status;
    if (cameraStatus.isDenied) {
      permissionsToRequest.add(Permission.camera);
    }
    
    // Solicitar todos los permisos necesarios al mismo tiempo
    if (permissionsToRequest.isNotEmpty) {
      await permissionsToRequest.request();
    }
  } catch (e) {
    // Error al solicitar permisos
  }
}

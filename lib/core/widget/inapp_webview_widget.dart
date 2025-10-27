import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shell_mfe_flutter/core/components/simple_loading_widget.dart';
import 'package:shell_mfe_flutter/core/theme/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

import '../../features/register/pages/register_step2_page.dart';


typedef OnCookiesRetrieved = void Function(List<Cookie> cookies);
typedef OnCameraAccessRequested = void Function(Map<String, dynamic> requestData);

class InappWebviewWidget extends StatefulWidget {
  const InappWebviewWidget(
      {super.key,
      required this.url,
      required this.pageToRedirect,
      required this.onCookiesRetrieved,
      this.onCameraAccessRequested});
  final String url;
  final String pageToRedirect;
  final OnCookiesRetrieved onCookiesRetrieved;
  final OnCameraAccessRequested? onCameraAccessRequested;

  @override
  State<InappWebviewWidget> createState() => _InappWebviewWidgetState();
}

class _InappWebviewWidgetState extends State<InappWebviewWidget> {
  InAppWebViewController? webViewController;
  bool isLoading = false;
  CookieManager cookieManager = CookieManager.instance();


  @override
  void initState() {
    super.initState();
    cookieManager.deleteAllCookies();
  }

  /// Manejar solicitud de acceso a cámara
  Future<void> _handleCameraAccessRequest(Map<String, dynamic> data) async {
    try {
      // Verificar estado actual de permisos
      final currentStatus = await Permission.camera.status;
      
      if (currentStatus.isGranted) {
        // Abrir cámara directamente
        if (data['reason'] == 'document_scan') {
          await _openDocumentScanner();
        }
      } else if (currentStatus.isDenied || currentStatus.isPermanentlyDenied) {
        // Mostrar opción para abrir configuración
        await _showSettingsDialog();
      }
    } catch (e) {
      // Error al manejar solicitud de cámara
    }
  }


  /// Mostrar diálogo para abrir configuración
  Future<void> _showSettingsDialog() async {
    if (!context.mounted) return;
    
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permisos Requeridos'),
          content: const Text(
            'Los permisos de cámara han sido denegados permanentemente. '
            'Por favor, ve a la configuración de la aplicación y habilita '
            'el acceso a la cámara manualmente.'
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Abrir Configuración'),
            ),
          ],
        );
      },
    );
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
    // Aquí puedes hacer lo que necesites con la imagen:
    // - Guardarla en el dispositivo
    // - Enviarla a un servidor
    // - Mostrarla en la UI
    // - etc.
    log('Imagen capturada: $image');
    Navigator.pushNamed(context, Registerstep2Page.routeName,);
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: InAppWebView(
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              allowUniversalAccessFromFileURLs: true,
              allowFileAccessFromFileURLs: true,
              javaScriptCanOpenWindowsAutomatically: true,
              domStorageEnabled: true,
              useShouldOverrideUrlLoading:
                  true, 
                  supportMultipleWindows: true,
            ),
          
            initialUrlRequest: URLRequest(
              url: WebUri(widget.url),
            ),
            onConsoleMessage: (controller, consoleMessage) {
              log('Console: ${consoleMessage.message}');
            },
            onJsAlert: (controller, jsAlertRequest) async {
              // Procesar mensajes JSON que vienen como alert
              try {
                final message = jsAlertRequest.message ?? '';
                final messageData = jsonDecode(message);
                
                if (messageData is Map<String, dynamic>) {
                  final action = messageData['action'];
                  final data = messageData['data'];
                  
                  if (action == 'REQUEST_CAMERA_ACCESS') {
                    // Llamar callback si está disponible
                    if (widget.onCameraAccessRequested != null) {
                      widget.onCameraAccessRequested!(data);
                    }
                    
                    // Procesar la solicitud de cámara
                    await _handleCameraAccessRequest(data);
                    
                    return JsAlertResponse(
                      handledByClient: true,
                      action: JsAlertResponseAction.CONFIRM,
                    );
                  }
                }
              } catch (e) {
                // Error al procesar mensaje JSON
              }

              return JsAlertResponse(
                handledByClient: true,
                action: JsAlertResponseAction.CONFIRM,
              );
            },
      
            onWebViewCreated: (controller) {
              webViewController = controller;
              webViewController!.addJavaScriptHandler(
                handlerName: 'flutterHandler',
                callback: (args) {
                  log('Evento recibido de JavaScript: $args');

                  if (args.isNotEmpty && args[0] == 'cookiesReady') {
                    final url = WebUri(widget.url);
                    cookieManager.getCookies(url: url).then((cookies) {
                      if (cookies.isNotEmpty) {
                        log("Cookies recibidas: ${cookies.length}");
                        widget.onCookiesRetrieved(cookies);
                      } else {
                        log("⚠️ No se encontraron cookies");
                      }
                    });
                  }

                  return null;
                },
              );
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              final url = navigationAction.request.url.toString();
              if (url.contains(widget.pageToRedirect)) {
                Navigator.pushNamed(context, widget.pageToRedirect,
                    arguments: url);
                return NavigationActionPolicy.CANCEL;
              }
              return NavigationActionPolicy.ALLOW;
            },
            
            onLoadStart: (controller, url) {
              log("Started loading: $url");
              setState(() {
                isLoading = true;
              });
            },
            onLoadStop: (controller, url) async {
              log("Finished loading: $url");


              setState(() {
                isLoading = false;
              });
            },
          ),
        ),
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: scaffoldColor,
              child: Center(
                child: SimpleLoadingWidget(),
              ),
            ),
          )
      ]),
    );
  }
}

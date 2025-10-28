import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shell_mfe_flutter/core/components/simple_loading_widget.dart';
import 'package:shell_mfe_flutter/core/theme/colors.dart';

typedef OnCookiesRetrieved = void Function(List<Cookie> cookies);
typedef OnJsAlert = void Function(String message);
typedef OnUrlNavigation = void Function(String url);
typedef OnWebViewCreated = void Function(InAppWebViewController controller);
typedef OnLoadStart = void Function(String url);
typedef OnLoadStop = void Function(String url);

class InappWebviewWidget extends StatelessWidget {
  const InappWebviewWidget({
    super.key,
    required this.url,
    required this.pageToRedirect,
    required this.onCookiesRetrieved,
    this.onJsAlert,
    this.onUrlNavigation,
    this.onWebViewCreated,
    this.onLoadStart,
    this.onLoadStop,
    this.isLoading = false,
  });

  final String url;
  final String pageToRedirect;
  final OnCookiesRetrieved onCookiesRetrieved;
  final OnJsAlert? onJsAlert;
  final OnUrlNavigation? onUrlNavigation;
  final OnWebViewCreated? onWebViewCreated;
  final OnLoadStart? onLoadStart;
  final OnLoadStop? onLoadStop;
  final bool isLoading;

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
              url: WebUri(url),
            ),
            onConsoleMessage: (controller, consoleMessage) {
              log('Console: ${consoleMessage.message}');
            },
            onJsAlert: (controller, jsAlertRequest) async {
              // Llamar callback si está disponible
              if (onJsAlert != null) {
                onJsAlert!(jsAlertRequest.message ?? '');
              }

              return JsAlertResponse(
                handledByClient: true,
                action: JsAlertResponseAction.CONFIRM,
              );
            },
      
            onWebViewCreated: (controller) {
              // Llamar callback si está disponible
              if (onWebViewCreated != null) {
                onWebViewCreated!(controller);
              }
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              final navigationUrl = navigationAction.request.url.toString();
              if (navigationUrl.contains(pageToRedirect)) {
                // Llamar callback si está disponible
                if (onUrlNavigation != null) {
                  onUrlNavigation!(navigationUrl);
                }
                return NavigationActionPolicy.CANCEL;
              }
              return NavigationActionPolicy.ALLOW;
            },
            
            onLoadStart: (controller, loadUrl) {
              log("Started loading: $loadUrl");
              // Llamar callback si está disponible
              if (onLoadStart != null) {
                onLoadStart!(loadUrl.toString());
              }
            },
            onLoadStop: (controller, loadUrl) async {
              log("Finished loading: $loadUrl");
              // Llamar callback si está disponible
              if (onLoadStop != null) {
                onLoadStop!(loadUrl.toString());
              }
            },
          ),
        ),
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: scaffoldColor,
              child: const Center(
                child: SimpleLoadingWidget(),
              ),
            ),
          )
      ]),
    );
  }
}

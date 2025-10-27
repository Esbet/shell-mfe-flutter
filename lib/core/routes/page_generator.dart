
import 'package:flutter/material.dart';
import 'package:shell_mfe_flutter/features/auth/pages/auth_page.dart';
import 'package:shell_mfe_flutter/features/register/pages/register_step2_page.dart';
import '../../features/register/pages/register_step1_page.dart';
import '../../splash_page.dart';

class PageClassGenerator {

  static Route<dynamic> getNamedScreen(RouteSettings routeSettings) {
    Widget Function(BuildContext) builder;

    switch (routeSettings.name) {
      case SplashPage.routeName:
        builder = (context) => const SplashPage();
        break;
        
      case AuthPage.routeName:
        builder = (context) => const AuthPage();
        break;

      case RegisterStep1Page.routeName:
        builder = (context) => const RegisterStep1Page();
        break;

      case Registerstep2Page.routeName:
        builder = (context) => const Registerstep2Page();
        break;

      //rutas de prueba
      default:
        builder = (context) => const Material(
              child: Center(child: Text("Todavia no se ha aplicado")),
            );
    }
    return _commonPageWrappper(
      routeSettings: routeSettings,
      builder: builder,
    );
  }

   /// Configuration method to create our own navigation
  static Route<dynamic> _commonPageWrappper({
    required RouteSettings routeSettings,
    required Widget Function(BuildContext) builder,
  }) {
    return PageRouteBuilder(
      settings: routeSettings,
      opaque: false, 
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container(
          color: Colors.transparent,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Opacity(
                opacity: animation.value,
                child: Container(
                  color: Colors.transparent,
                  child: SafeArea(
                    top: false, 
                    bottom: false, 
                    child: builder(context)
                  ),
                ),
              );
            },
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 100),
    );
  }
}
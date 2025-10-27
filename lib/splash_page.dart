import 'package:flutter/material.dart';
import 'package:shell_mfe_flutter/core/utils/resource_icons.dart';
import 'package:shell_mfe_flutter/features/auth/pages/auth_page.dart';
import 'core/theme/colors.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const routeName = "/splash";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    processScreen();

  }

  Future<void> processScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    navigation();
  }

  void navigation() {
   Navigator.pushReplacementNamed(context, AuthPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondColor,
      body: SafeArea(child: Container( child: _mainScreen())),
    );
  }

  Widget _mainScreen() {
    return Stack(
      children: [
        _titleScreen(),
      ],
    );
  }

  Widget _titleScreen() {
    return Align(
      alignment: Alignment.center,
      child: Image(
        image: const AssetImage(splashLogo),
        height: 300,
        width: 300,
        fit: BoxFit.contain,
      ),
    );
  }
}

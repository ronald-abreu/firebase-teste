import 'package:flutter/material.dart';
import 'package:zapzap2/cadastro_screen.dart';
import 'package:zapzap2/login_screen.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  bool showLoginScreen = true;

  //mudar entre login e cadastro

  void alternarScreens() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(
        onTap: alternarScreens,
      );
    } else {
      return CadastroScreen(
        onTap: alternarScreens,
      );
    }
  }
}

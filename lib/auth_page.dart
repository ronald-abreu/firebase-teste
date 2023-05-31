import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zapzap2/chat_screen.dart';
import 'package:zapzap2/login_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // usuário logado
          if (snapshot.hasData) {
            return ChatScreen();
          }

          //usuário não logado
          else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}

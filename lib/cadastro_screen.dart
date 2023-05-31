import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_screen.dart';
import 'cadastro_screen.dart';

class CadastroScreen extends StatefulWidget {
  final Function()? onTap;
  const CadastroScreen({super.key, required this.onTap});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmSenhaController = TextEditingController();

  void cadastro() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (senhaController.text == confirmSenhaController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: senhaController.text,
        );
      } else {
        passwordDontMatch();
      }

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongData();
      } else if (e.code == 'wrong-password') {
        wrongData();
      }
    }
  }

  void wrongData() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Email ou senha incorretos'),
        );
      },
    );
  }

  void passwordDontMatch() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Senhas não conferem'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Cadastro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: senhaController,
              obscureText: false,
              decoration: InputDecoration(labelText: 'Senha'),
            ),
            TextFormField(
              controller: confirmSenhaController,
              obscureText: false,
              decoration: InputDecoration(labelText: 'Confirmar Senha'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: cadastro,
              child: Text('Confirmar'),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

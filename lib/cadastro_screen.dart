import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    Navigator.pop(context);
    if (senhaController.text != confirmSenhaController.text) {
      Navigator.pop(context);
      showMessage("Senhas não coincidem");
      return;
    }

    try {
      senhaController.text == confirmSenhaController.text;
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: senhaController.text,
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        showMessage('Senha Fraca');
      } else if (e.code == 'email-already-in-use') {
        showMessage('Email ja em uso');
      }
    }
  }

  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Cadastro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: senhaController,
              obscureText: false,
              decoration: const InputDecoration(labelText: 'Senha (mín. 6 dígitos)'),
            ),
            TextFormField(
              controller: confirmSenhaController,
              obscureText: false,
              decoration: const InputDecoration(labelText: 'Confirmar Senha'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: cadastro,
              child: const Text('Confirmar'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

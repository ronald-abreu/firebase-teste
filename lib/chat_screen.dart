import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final emailController = TextEditingController();
  List<String> messages = [];

  @override
  void dispose() {
    messageController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future pegarDados(String message, String user) async {
    await FirebaseFirestore.instance.collection('mensagens').add({
      'message': message,
    });
  }

  void sendMessage() {
    pegarDados(messageController.text.trim(), emailController.text.trim());
    String message = messageController.text;

    setState(() {
      messages.add(message);
      messageController.clear();
    });
  }

  void LogOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: LogOut,
            icon: const Icon(Icons.logout),
          )
        ],
        title: const Text('Tela de Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(message),
                );
              },
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: const InputDecoration(labelText: 'Mensagem'),
                  ),
                ),
                IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

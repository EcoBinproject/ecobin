import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String _email = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return 'L\'email non può essere vuota';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zAZ0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return 'Email non valida';
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Link di recupero inviato all\'email')),
      );
      Navigator.pop(context); // Torna alla schermata di login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recupera Password"),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 80.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Titolo e campo per l'email
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  'Inserisci la tua email per ricevere un link di recupero.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Inserisci un\'email valida',
                  ),
                  validator: validateEmail,
                  onChanged: (text) => setState(() => _email = text),
                ),
              ),
              // Bottone per inviare il link di recupero
              Container(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Invia Link di Recupero',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

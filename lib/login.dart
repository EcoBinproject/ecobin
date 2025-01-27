import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password_screen.dart'; // Importa la schermata di recupero password
import 'homepage.dart';
import 'register_screen.dart'; // Importa la schermata di registrazione
import 'user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passToggle = true;
  String _email = '';
  String _password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Funzione per la validazione dell'email
  String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return 'L\'email non può essere vuota';
    }
    if (email.length < 4) {
      return 'Email troppo corta';
    }
    if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return 'Email non valida';
    }
    return null;
  }

  // Funzione per la validazione della password
  String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return 'La password non può essere vuota';
    }
    if (password.length < 6) {
      return 'La password deve essere di almeno 6 caratteri';
    }
    return null;
  }

  // Funzione per eseguire il login
  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final prefs = await SharedPreferences.getInstance();
      final savedEmail = prefs.getString('email');
      final savedPassword = prefs.getString('password');

      if (savedEmail == _email && savedPassword == _password) {
        // Login riuscito
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login effettuato con successo')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              user: User(
                name: _email, // Passa l'email come nome utente
                email: _email, // Passa l'email anche come email utente
              ),
            ),
          ),
        );
      } else {
        // Credenziali non corrispondono
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email o password errati')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 80.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Aggiungere un'animazione di fading per il logo
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(seconds: 1),
                child: Center(
                  child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/images/boy.png'),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Campo Email con design più moderno
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.green[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.green[700]),
                    hintText: 'Inserisci un\'email valida',
                  ),
                  validator: validateEmail,
                  onChanged: (text) => setState(() => _email = text),
                ),
              ),

              // Campo Password con un effetto più fluido
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.green[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock, color: Colors.green),
                    hintText: 'Inserisci una password sicura',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(
                        passToggle ? Icons.visibility : Icons.visibility_off,
                        color: Colors.green[700],
                      ),
                    ),
                  ),
                  validator: validatePassword,
                  onChanged: (text) => setState(() => _password = text),
                ),
              ),

              // Link per il recupero della password con uno stile accattivante
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen()),
                    );
                  },
                  child: const Text(
                    'Password dimenticata?',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
              ),

              // Bottone di login con un'animazione di attivazione
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color:
                      _email.isNotEmpty ? Colors.green[700] : Colors.green[200],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: _email.isNotEmpty ? _submit : null,
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),

              // Link per la registrazione con un design più morbido
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationScreen()),
                  );
                },
                child: const Text(
                  'Nuovo utente? Crea un account',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

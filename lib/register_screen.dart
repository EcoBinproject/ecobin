import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  // Funzione per registrare e salvare i dati
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      // Salva le credenziali nel dispositivo
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', _email);
      prefs.setString('password',
          _password); // Considera di criptare la password per maggiore sicurezza

      // Mostra un messaggio di conferma
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registrazione completata')));

      // Puoi anche navigare ad un'altra schermata dopo la registrazione
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrazione'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Crea il tuo account',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(height: 20),
              // Campo Nome
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                    value!.isEmpty ? 'Inserisci il tuo nome' : null,
                onChanged: (value) => _name = value,
              ),
              SizedBox(height: 10),
              // Campo Email
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty || !value.contains('@')
                    ? 'Inserisci un\'email valida'
                    : null,
                onChanged: (value) => _email = value,
              ),
              SizedBox(height: 10),
              // Campo Password
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value!.isEmpty || value.length < 6
                    ? 'La password deve essere lunga almeno 6 caratteri'
                    : null,
                onChanged: (value) => _password = value,
              ),
              SizedBox(height: 10),
              // Campo Conferma Password
              TextFormField(
                decoration: InputDecoration(labelText: 'Conferma Password'),
                obscureText: true,
                validator: (value) =>
                    value != _password ? 'Le password non corrispondono' : null,
                onChanged: (value) => _confirmPassword = value,
              ),
              SizedBox(height: 20),
              // Bottone Registrati
              ElevatedButton(
                onPressed: _register,
                child: Text('Registrati', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  // Cambiato per evitare il parametro `primary`
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

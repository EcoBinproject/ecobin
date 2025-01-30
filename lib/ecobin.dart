import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepage.dart';
import 'user.dart'; // Assicurati che la tua classe User sia importata

void main() {
  // Crea un oggetto User (puoi fare questa parte in base ai tuoi dati)
  User user = User(name: 'Mario Rossi', email: 'mario@example.com');

  runApp(EcoBinApp(
      user: user)); // Passa l'oggetto user al costruttore di EcoBinApp
}

class EcoBinApp extends StatelessWidget {
  final User user; // Aggiungi un campo per ricevere l'utente

  // Modifica il costruttore per ricevere l'utente
  const EcoBinApp({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoBin',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: HomePage(user: user), // Passa l'utente alla HomePage
    );
  }
}


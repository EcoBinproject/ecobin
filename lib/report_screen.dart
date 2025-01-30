import 'dart:io'; // Per gestire le immagini come File

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Per selezionare l'immagine
import 'package:url_launcher/url_launcher.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? selectedRecipient =
      'Comune'; // Valore di default per il menu a discesa
  File? _image; // Variabile per la foto selezionata

  final ImagePicker _picker = ImagePicker(); // Per selezionare l'immagine

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Segnalazioni',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange[700],
        elevation: 10,
        shadowColor: Colors.orange[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildReportForm(),
            Divider(color: Colors.grey[400], thickness: 1),
            _buildEmergencyContacts(), // Sezione per le chiamate rapide
          ],
        ),
      ),
    );
  }

  Widget _buildReportForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Segnala un problema ambientale',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.orange[900],
          ),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: selectedRecipient,
          items: [
            DropdownMenuItem(
              value: 'Comune',
              child: Text('Invia al Comune'),
            ),
            DropdownMenuItem(
              value: 'Autorità Competenti',
              child: Text('Invia alle Autorità Competenti'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedRecipient = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Seleziona destinatario',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Descrizione del problema',
            hintText: 'Descrivi il problema che hai osservato',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Posizione',
            hintText: 'Inserisci la posizione (opzionale)',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        // Aggiungi il pulsante per selezionare la foto
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.camera_alt),
          label: Text('Seleziona una foto'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[700],
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        SizedBox(height: 16),
        // Se l'immagine è selezionata, mostrala
        if (_image != null)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Image.file(_image!),
          ),
        SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () {
            _showConfirmationDialog(context);
          },
          icon: Icon(Icons.send),
          label: Text('Invia Segnalazione'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[700],
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }

  // Funzione per selezionare l'immagine dalla galleria o fotocamera
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Assegna il file immagine
      });
    }
  }

  Widget _buildEmergencyContacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Contatta Autorità Competenti',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.red[700],
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildEmergencyButton(
              'Carabinieri',
              Icons.local_police,
              '112', // Numero per i Carabinieri
              Colors.blue[700]!,
            ),
            _buildEmergencyButton(
              'Polizia',
              Icons.security,
              '113', // Numero per la Polizia
              Colors.green[700]!,
            ),
            _buildEmergencyButton(
              'Vigili Urbani',
              Icons.directions_car,
              '114', // Numero per i Vigili Urbani
              Colors.orange[700]!,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmergencyButton(
      String label, IconData icon, String number, Color color) {
    return ElevatedButton.icon(
      onPressed: () {
        _makePhoneCall(number);
      },
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  void _makePhoneCall(String number) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Impossibile avviare la chiamata al numero $number';
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Grazie per la tua segnalazione!'),
          content: Text(
            'La tua segnalazione è stata inviata a "$selectedRecipient". Ti ringraziamo per il tuo contributo!',
          ),
          actions: [
            TextButton(
              child: Text('Chiudi'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

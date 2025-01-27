import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'homepage.dart';
void main() {
  runApp(MaterialApp(
    home: HomePage(),  // Use HomePage here instead of Main
  ));
}

class Main extends StatelessWidget {
  final int totalRecycledItems = 150; // Un esempio di dato per il riciclo totale

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          _buildInteractiveGlobe(),
          SizedBox(height: 20),
          _buildEcoBadgeSection(),
          SizedBox(height: 20),
          _buildCommunityChallengeSection(),
        ],
      ),
    );
  }

  Widget _buildInteractiveGlobe() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Il Tuo Impatto sul Pianeta',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green[767],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Lottie.asset(
            'assets/animations/globe_animation.json',
            height: 200,
          ),
          SizedBox(height: 10),
          Text(
            'Grazie al tuo impegno, il pianeta è un posto migliore!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEcoBadgeSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'I Tuoi EcoBadge',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBadge('Salvatore degli Oceani', Icons.water, Colors.blue),
              _buildBadge('Custode del Verde', Icons.park, Colors.green),
              _buildBadge('Riduttore di CO₂', Icons.energy_savings_leaf, Colors.orange),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Ottieni più badge completando missioni ecologiche!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String title, IconData icon, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
          color: color,
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCommunityChallengeSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[300]!, Colors.green[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sfida della Comunità',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Unisciti ad altri 10,000 utenti nel fare del pianeta un posto migliore.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: 0.7, // Ad esempio, 70% completato
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green[700]!),
          ),
          SizedBox(height: 10),
          Text(
            '70% del nostro obiettivo raggiunto! Continua così!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.green[800],
            ),
          ),
        ],
      ),
    );
  }
}
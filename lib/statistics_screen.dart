import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  final int ecoPoints = 120;
  final int ecoBadges = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Statistiche Personali',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green[700], // Green for the title
              fontSize: 24,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Le tue statistiche ecologiche',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[700], // Green color for subtitle
              ),
            ),
            SizedBox(height: 20),
            _buildStatisticCard(
                'Punti Ecologici', ecoPoints.toString(), Colors.green[300]!),
            SizedBox(height: 10),
            _buildStatisticCard(
                'Badges Guadagnati', ecoBadges.toString(), Colors.blue[300]!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Torna alla Home',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700], // Updated parameter
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticCard(String title, String value, Color color) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 18,
          ),
        ),
        trailing: Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

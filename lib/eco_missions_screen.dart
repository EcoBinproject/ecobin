import 'package:flutter/material.dart';

class EcoMissionsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> ecoMissions = [
    {
      'title': 'Ricicla 10 Bottiglie',
      'description': 'Conferisci 10 bottiglie di plastica nel bidone corretto.',
      'points': 10,
      'icon': Icons.recycling,
    },
    {
      'title': 'Usa una Borraccia',
      'description': 'Sostituisci 5 bottiglie di plastica con una borraccia.',
      'points': 20,
      'icon': Icons.local_drink_outlined,
    },
    {
      'title': 'Cammina invece di Guidare',
      'description': 'Cammina o usa la bici per 5 km al posto dell’auto.',
      'points': 15,
      'icon': Icons.directions_walk,
    },
    {
      'title': 'Pianta un Albero',
      'description': 'Pianta un albero nella tua comunità o giardino.',
      'points': 30,
      'icon': Icons.park,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EcoMissioni'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: ecoMissions.length,
          itemBuilder: (context, index) {
            final mission = ecoMissions[index];
            return _buildMissionCard(mission);
          },
        ),
      ),
    );
  }

  Widget _buildMissionCard(Map<String, dynamic> mission) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              mission['icon'],
              size: 30,
              color: Colors.green[700],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mission['title'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  mission['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '+${mission['points']} pt',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

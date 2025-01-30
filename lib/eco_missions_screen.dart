import 'package:flutter/material.dart';

class EcoMissionsScreen extends StatefulWidget {
  @override
  _EcoMissionsScreenState createState() => _EcoMissionsScreenState();
}

class _EcoMissionsScreenState extends State<EcoMissionsScreen> {
  final List<Map<String, dynamic>> ecoMissions = [
    {
      'title': 'Ricicla 10 Bottiglie',
      'description': 'Conferisci 10 bottiglie di plastica nel bidone corretto.',
      'points': 10,
      'icon': Icons.recycling,
      'completed': false,
    },
    {
      'title': 'Usa una Borraccia',
      'description': 'Sostituisci 5 bottiglie di plastica con una borraccia.',
      'points': 20,
      'icon': Icons.local_drink_outlined,
      'completed': false,
    },
    {
      'title': 'Cammina invece di Guidare',
      'description': 'Cammina o usa la bici per 5 km al posto dell’auto.',
      'points': 15,
      'icon': Icons.directions_walk,
      'completed': false,
    },
    {
      'title': 'Pianta un Albero',
      'description': 'Pianta un albero nella tua comunità o giardino.',
      'points': 30,
      'icon': Icons.park,
      'completed': false,
    },
  ];

  void _toggleCompletion(int index) {
    setState(() {
      ecoMissions[index]['completed'] = !ecoMissions[index]['completed'];
    });
  }

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
            'EcoMissioni',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: ecoMissions.length,
            itemBuilder: (context, index) {
              final mission = ecoMissions[index];
              return _buildMissionCard(mission, index);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMissionCard(Map<String, dynamic> mission, int index) {
    return GestureDetector(
      onTap: () => _toggleCompletion(index),
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: mission['completed']
              ? LinearGradient(colors: [Colors.green[200]!, Colors.green[100]!])
              : LinearGradient(colors: [Colors.white, Colors.white]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                mission['completed'] ? Colors.green[600]! : Colors.transparent,
            width: 2,
          ),
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
                color: mission['completed']
                    ? Colors.green[300]
                    : Colors.green[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                mission['icon'],
                size: 30,
                color: mission['completed']
                    ? Colors.green[800]
                    : Colors.green[700],
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
                      color: mission['completed']
                          ? Colors.green[700]
                          : Colors.green[800],
                      decoration: mission['completed']
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    mission['description'],
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          mission['completed'] ? Colors.grey : Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '+${mission['points']} pt',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: mission['completed']
                        ? Colors.green[700]
                        : Colors.green[800],
                  ),
                ),
                SizedBox(height: 4),
                Icon(
                  mission['completed']
                      ? Icons.check_circle
                      : Icons.arrow_forward_ios,
                  color: mission['completed'] ? Colors.green[700] : Colors.grey,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

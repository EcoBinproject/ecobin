import 'package:ecobin/main.dart';
import 'package:flutter/material.dart';

import 'community_screen.dart';
import 'eco_missions_screen.dart';
import 'map_screen.dart';
import 'quiz_screen.dart';
import 'report_screen.dart';
import 'statistics_screen.dart';
import 'user.dart'; // Importa la classe User

// Classe HomePage modificata per ricevere l'utente
class HomePage extends StatefulWidget {
  final User user; // Aggiungi il campo user che riceverai dal login

  // Modifica il costruttore per ricevere l'utente
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final _pages = <Widget>[
    Main(),
    // Questa era la tua pagina principale. Se vuoi che punti a qualcos'altro, modificare qui.
    EcoMissionsScreen(),
    MapScreen(),
    StatisticsScreen(),
    QuizScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EcoBin',
          style: TextStyle(
            fontSize: screenWidth > 600 ? 30 : 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: Column(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _pages[_selectedIndex],
            ),
          ),
          SizedBox(height: 10),
          if (_selectedIndex == 0) _buildUtilitySection(screenWidth),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.user.name),
            // Usa il nome dell'utente passato
            accountEmail: Text(widget.user.email),
            // Usa l'email dell'utente
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
            decoration: BoxDecoration(
              color: Colors.green[700],
              image: DecorationImage(
                image: AssetImage('assets/images/drawer_bg.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          _buildDrawerItem(Icons.settings, 'Impostazioni'),
          _buildDrawerItem(Icons.info_outline, 'Informazioni sul Riciclo'),
          _buildDrawerItem(Icons.feedback_outlined, 'Feedback'),
          _buildDrawerItem(Icons.support_agent_outlined, 'Supporto e Contatti'),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.green[700]),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildUtilitySection(double screenWidth) {
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          double cardWidth = screenWidth > 600
              ? (screenWidth / 3 - 20)
              : (screenWidth - 40); // Imposta la larghezza delle card
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // Aggiusta la disposizione delle card
            children: [
              // Prima card: Community
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: _buildCommunityCard(),
                ),
              ),
              // Seconda card: Report
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: _buildReportCard(),
                ),
              ),
              // Terza card: Quiz
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: _buildQuizCard(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCommunityCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CommunityScreen()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[300]!, Colors.green[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people, color: Colors.white, size: 20),
            SizedBox(height: 8),
            Text(
              'Community',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            Text(
              'Unisciti alla community e collabora!',
              style: TextStyle(
                fontSize: 8,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReportScreen()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange[300]!, Colors.orange[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.report_problem, color: Colors.white, size: 20),
            SizedBox(height: 8),
            Text(
              'Segnalazioni',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.orange[900],
              ),
            ),
            Text(
              'Segnala problemi al comune o alle autorità!',
              style: TextStyle(
                fontSize: 8,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizScreen()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[300]!, Colors.blue[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.quiz, color: Colors.white, size: 20),
            SizedBox(height: 8),
            Text(
              'Quiz',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            Text(
              'Metti alla prova le tue conoscenze!',
              style: TextStyle(
                fontSize: 8,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          items: [
            _buildNavBarItem(Icons.home, 'Home'),
            _buildNavBarItem(Icons.star, 'EcoMissioni'),
            _buildNavBarItem(Icons.map, 'Mappa'),
            _buildNavBarItem(Icons.bar_chart, 'Statistiche'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green[700],
          unselectedItemColor: Colors.grey[600],
          selectedFontSize: 14,
          unselectedFontSize: 12,
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}


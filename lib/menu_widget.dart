import 'package:flutter/material.dart';

class EcoBinMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const EcoBinMenu({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[700]!, Colors.green[400]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed, // Assicura che tutte le icone siano visibili
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.home, isSelected: selectedIndex == 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.star_border, isSelected: selectedIndex == 1),
            label: 'EcoMissioni',
          ),
          BottomNavigationBarItem(
            icon:
                _buildIcon(Icons.map_outlined, isSelected: selectedIndex == 2),
            label: 'Mappa',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.bar_chart, isSelected: selectedIndex == 3),
            label: 'Statistiche',
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData iconData, {required bool isSelected}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.all(isSelected ? 8 : 0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        size: isSelected ? 28 : 24,
      ),
    );
  }
}


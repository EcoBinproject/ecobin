import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  LatLng _initialPosition = LatLng(41.9028, 12.4964); // Roma, Italia
  TextEditingController _searchController = TextEditingController();
  Map<String, List<String>> _wasteCalendar = {
    'Roma': ['Lunedì: Plastica', 'Martedì: Carta', 'Mercoledì: Organico'],
    'Milano': ['Lunedì: Carta', 'Martedì: Plastica', 'Mercoledì: Vetro'],
    'Napoli': ['Lunedì: Indifferenziato', 'Martedì: Organico', 'Mercoledì: Carta'],
  };
  Map<String, List<LatLng>> _collectionCenters = {
    'Roma': [LatLng(41.9109, 12.4818), LatLng(41.9027, 12.4534)],
    'Milano': [LatLng(45.4642, 9.1900), LatLng(45.4722, 9.1825)],
    'Napoli': [LatLng(40.8518, 14.2681), LatLng(40.8500, 14.2500)],
  };
  List<String> _currentCalendar = [];
  List<LatLng> _currentCenters = [];

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() {
    _markers.addAll([
      Marker(
        markerId: MarkerId('recycling_center'),
        position: LatLng(41.9109, 12.4818),
        infoWindow: InfoWindow(
          title: 'Centro di Riciclaggio',
          snippet: 'Porta qui i tuoi rifiuti per il riciclo.',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    ]);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final targetLocation = locations.first;
        LatLng newPosition =
            LatLng(targetLocation.latitude, targetLocation.longitude);

        // Aggiorna la posizione della mappa
        _mapController.animateCamera(
          CameraUpdate.newLatLngZoom(newPosition, 14),
        );

        // Aggiungi un marker per la nuova posizione
        setState(() {
          _markers.add(
            Marker(
              markerId: MarkerId(query),
              position: newPosition,
              infoWindow: InfoWindow(
                title: query,
                snippet: 'Luogo selezionato',
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
            ),
          );

          // Aggiorna calendario e centri di raccolta
          _currentCalendar = _wasteCalendar[query] ?? [];
          _currentCenters = _collectionCenters[query] ?? [];
        });
      } else {
        _showErrorSnackbar('Nessun risultato trovato.');
      }
    } catch (e) {
      _showErrorSnackbar('Errore durante la ricerca: ${e.toString()}');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mappe e Calendario',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.green[700],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 13,
            ),
            markers: _markers,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
          ),
          _buildSearchBar(),
          if (_currentCalendar.isNotEmpty || _currentCenters.isNotEmpty)
            _buildInfoPanel(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Positioned(
      top: 20,
      left: 16,
      right: 16,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cerca un comune...',
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    _searchLocation(value);
                  }
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.green[700]),
              onPressed: () {
                if (_searchController.text.isNotEmpty) {
                  _searchLocation(_searchController.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoPanel() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 200,
        width: double.infinity,
        margin: EdgeInsets.all(16),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calendario Rifiuti',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            ..._currentCalendar.map((day) => Text(day)).toList(),
            SizedBox(height: 16),
            Text(
              'Centri di Raccolta',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            ..._currentCenters.map((center) => Text(
              'Lat: ${center.latitude}, Lng: ${center.longitude}',
            )),
          ],
        ),
      ),
    );
  }
}



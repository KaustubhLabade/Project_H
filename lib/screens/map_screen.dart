import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng? _initialPosition;
  LatLng? _selectedDestination;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  // Get user's current location
  Future<void> _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Destination'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _initialPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _initialPosition!,
          zoom: 14,
        ),
        onTap: (LatLng position) {
          setState(() {
            _selectedDestination = position;
          });
        },
        markers: _selectedDestination != null
            ? {
          Marker(
            markerId: MarkerId('destination'),
            position: _selectedDestination!,
            infoWindow: InfoWindow(title: 'Selected Destination'),
          )
        }
            : {},
      ),
      bottomNavigationBar: _selectedDestination != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, _selectedDestination);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.blueAccent,
          ),
          child: Text('Confirm Destination', style: TextStyle(fontSize: 18)),
        ),
      )
          : null,
    );
  }
}

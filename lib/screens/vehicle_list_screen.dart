import 'package:flutter/material.dart';
import '../services/vehicle_service.dart'; // Make sure this path matches your project structure

class VehicleListScreen extends StatefulWidget {
  final String phoneNumber;

  VehicleListScreen({required this.phoneNumber});

  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  late Future<List<Map<String, dynamic>>?> _vehicleFuture;

  @override
  void initState() {
    super.initState();
    // Fetch vehicles when the screen initializes
    _vehicleFuture = VehicleService().fetchVehicles(widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Vehicles'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: _vehicleFuture,
        builder: (context, snapshot) {
          // Check the state of the Future
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No vehicles found.'));
          }

          // Data fetched successfully
          final vehicles = snapshot.data!;

          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return Card(
                color: Colors.grey[850], // Style to match the app's theme
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                    'Vehicle: ${vehicle['vehicleRegNo']}',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Owner: ${vehicle['ownerName']}', style: TextStyle(color: Colors.white70)),
                      Text('Type: ${vehicle['vehicleType']}', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  trailing: Icon(Icons.directions_car, color: Colors.blueAccent),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

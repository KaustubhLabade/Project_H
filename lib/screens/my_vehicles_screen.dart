import 'package:flutter/material.dart';

class MyVehiclesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Vehicles'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildVehicleCard('Vehicle 1', 'AB123CD', 'Toyota', 'Camry'),
            _buildVehicleCard('Vehicle 2', 'EF456GH', 'Honda', 'Civic'),
            _buildVehicleCard('Vehicle 3', 'IJ789KL', 'Ford', 'Focus'),
          ],
        ),
      ),
    );
  }

  // Helper method to build a vehicle card
  Widget _buildVehicleCard(String vehicleName, String regNo, String manufacturer, String model) {
    return Card(
      color: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vehicleName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Reg No: $regNo',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              'Manufacturer: $manufacturer',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              'Model: $model',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

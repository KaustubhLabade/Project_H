import 'package:flutter/material.dart';
import 'package:highwaypluss/screens/home_screen.dart';

class ProfileScreen extends StatelessWidget {
  // Fields for displaying profile data
  final String ownerName;
  final String vehicleRegNo;
  final String licenceNo;
  final String vehicleType;
  final String manufacturer;
  final String model;

  // Constructor to accept required fields
  ProfileScreen({
    required this.ownerName,
    required this.vehicleRegNo,
    required this.licenceNo,
    required this.vehicleType,
    required this.manufacturer,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Display Owner Information
            _buildProfileItem('Owner Name', ownerName),
            _buildProfileItem('Licence No', licenceNo),

            SizedBox(height: 20),

            // Display Vehicle Information
            _buildProfileItem('Vehicle Registration No', vehicleRegNo),
            _buildProfileItem('Vehicle Type', vehicleType),
            _buildProfileItem('Manufacturer', manufacturer),
            _buildProfileItem('Model', model),

            SizedBox(height: 40),

            // Button to navigate back or edit profile (optional)
            ElevatedButton(
              onPressed: () {
                // Navigate to edit profile or other functionality
                print('Edit Profile/Vehicle Info');
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build profile items
  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

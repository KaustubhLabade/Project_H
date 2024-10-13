import 'package:flutter/material.dart';

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
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // Background color or image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Foreground content with padding
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Profile Information',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),

                // Profile information cards
                _buildProfileCard('Owner Name', ownerName),
                _buildProfileCard('Licence No', licenceNo),
                _buildProfileCard('Vehicle Registration No', vehicleRegNo),
                _buildProfileCard('Vehicle Type', vehicleType),
                _buildProfileCard('Manufacturer', manufacturer),
                _buildProfileCard('Model', model),

                SizedBox(height: 40),

                // Edit Profile Button
                ElevatedButton(
                  onPressed: () {
                    print('Edit Profile/Vehicle Info');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Edit Profile', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build profile cards
  Widget _buildProfileCard(String label, String value) {
    return Card(
      color: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                '$label: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

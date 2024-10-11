import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'), // Ensure the background image exists
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Foreground content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome message
                Text(
                  'Welcome to Highway Plus!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),

                // Navigation cards
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      _buildNavigationCard(
                        icon: Icons.directions_car,
                        label: 'My Vehicles',
                        onTap: () {
                          // Handle tap event (navigate to My Vehicles screen)
                          Navigator.pushNamed(context, '/myVehicles');
                        },
                      ),
                      _buildNavigationCard(
                        icon: Icons.history,
                        label: 'Journey History',
                        onTap: () {
                          // Handle tap event (navigate to Journey History screen)
                          Navigator.pushNamed(context, '/journeyHistory');
                        },
                      ),
                      _buildNavigationCard(
                        icon: Icons.location_on,
                        label: 'Nearby Services',
                        onTap: () {
                          // Handle tap event (navigate to Nearby Services screen)
                          Navigator.pushNamed(context, '/nearbyServices');
                        },
                      ),
                      _buildNavigationCard(
                        icon: Icons.person,
                        label: 'Profile',
                        onTap: () {
                          // Handle tap event (navigate to Profile screen)
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
                      _buildNavigationCard(
                        icon: Icons.settings,
                        label: 'Settings',
                        onTap: () {
                          // Handle tap event (navigate to Settings screen)
                          Navigator.pushNamed(context, '/settings');
                        },
                      ),
                      _buildNavigationCard(
                        icon: Icons.exit_to_app,
                        label: 'Logout',
                        onTap: () {
                          // Handle logout
                          Navigator.pushReplacementNamed(context, '/');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a navigation card
  Widget _buildNavigationCard({
    required IconData icon,
    required String label,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        color: Colors.black.withOpacity(0.5),  // Add transparency to match the background
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

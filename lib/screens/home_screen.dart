import 'package:flutter/material.dart';
import 'profile_screen.dart';  // Import Profile Screen for navigation

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
                image: AssetImage('assets/images/background.jpg'),
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
                          Navigator.pushNamed(context, '/myVehicles');
                        },
                      ),
                      _buildNavigationCard(
                        icon: Icons.history,
                        label: 'Journey History',
                        onTap: () {
                          Navigator.pushNamed(context, '/journeyHistory');
                        },
                      ),
                      _buildNavigationCard(
                        icon: Icons.location_on,
                        label: 'Nearby Services',
                        onTap: () {
                          Navigator.pushNamed(context, '/nearbyServices');
                        },
                      ),
                      _buildNavigationCard(
                        icon: Icons.person,
                        label: 'Profile',
                        onTap: () {
                          Navigator.pushNamed(context, '/profileScreen');
                        },
                      ),
                      _buildNavigationCard(
                        icon: Icons.settings,
                        label: 'Settings',
                        onTap: () {
                          Navigator.pushNamed(context, '/settings');  // Navigate to Settings Screen
                        },
                      ),
                      _buildNavigationCard(
                        icon: Icons.exit_to_app,
                        label: 'Logout',
                        onTap: () {
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
        color: Colors.black.withOpacity(0.5),
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

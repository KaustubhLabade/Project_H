import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homey', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Welcome Home!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Grid layout for features
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildFeatureCard(
                      context: context,
                      icon: Icons.directions_car,
                      label: 'My Vehicles',
                      color: Colors.blue,
                      routeName: '/myVehicles',
                    ),
                    _buildFeatureCard(
                      context: context,
                      icon: Icons.history,
                      label: 'Journey History',
                      color: Colors.green,
                      routeName: '/journeyHistory',
                    ),
                    _buildFeatureCard(
                      context: context,
                      icon: Icons.location_on,
                      label: 'Nearby Services',
                      color: Colors.orange,
                      routeName: '/nearbyServices',
                    ),
                    _buildFeatureCard(
                      context: context,
                      icon: Icons.person,
                      label: 'Profile',
                      color: Colors.purple,
                      routeName: '/profileScreen',
                    ),
                    _buildFeatureCard(
                      context: context,
                      icon: Icons.settings,
                      label: 'Settings',
                      color: Colors.teal,
                      routeName: '/settings',
                    ),
                    _buildFeatureCard(
                      context: context,
                      icon: Icons.card_membership,
                      label: 'Get Membership',
                      color: Colors.amber,
                      routeName: '/membershipScreen',
                    ),
                    _buildFeatureCard(
                      context: context,
                      icon: Icons.exit_to_app,
                      label: 'Logout',
                      color: Colors.red,
                      routeName: '/',
                      isLogout: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build each feature card
  Widget _buildFeatureCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required String routeName,
    bool isLogout = false,
  }) {
    return GestureDetector(
      onTap: () {
        if (isLogout) {
          Navigator.pushReplacementNamed(context, routeName);
        } else {
          Navigator.pushNamed(context, routeName).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Route not found'),
                backgroundColor: Colors.redAccent,
                duration: Duration(seconds: 2),
              ),
            );
          });
        }
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 16),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

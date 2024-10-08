import 'package:flutter/material.dart';

import 'login_screen.dart'; // Adjust the path if needed

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to the LoginScreen after a delay
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()), // Make sure LoginScreen is defined
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your app's logo
            Icon(
              Icons.directions_car,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            // Your app's name or slogan
            Text(
              'Vehicle Registration App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            // Loading indicator
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}

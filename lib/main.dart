import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/vehicle_form_screen.dart';
import 'screens/home_screen.dart';  // Import all relevant screens

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Highway Plus App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/otpScreen': (context) => OtpScreen(),
        '/vehicleFormScreen': (context) => VehicleFormScreen(),  // Register Vehicle Form route
        '/homeScreen': (context) => HomeScreen(),  // Register Home Screen route
      },
    );
  }
}

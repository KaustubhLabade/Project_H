import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/vehicle_form_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/my_vehicles_screen.dart';
import 'screens/journey_history_screen.dart';
import 'screens/settings_screen.dart';  // Import SettingsScreen

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
        '/vehicleFormScreen': (context) => VehicleFormScreen(),
        '/homeScreen': (context) => HomeScreen(),
        '/profileScreen': (context) => ProfileScreen(
          ownerName: 'John Doe',
          vehicleRegNo: 'AB123CD',
          licenceNo: 'LIC12345',
          vehicleType: 'Sedan',
          manufacturer: 'Toyota',
          model: 'Camry',
        ),
        '/myVehicles': (context) => MyVehiclesScreen(),
        '/journeyHistory': (context) => JourneyHistoryScreen(),
        '/settings': (context) => SettingsScreen(),  // Register Settings Screen route
      },
    );
  }
}

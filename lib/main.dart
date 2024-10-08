import 'package:flutter/material.dart';
import 'package:highwaypluss/screens/splash_screen.dart';
import 'package:highwaypluss/screens/login_screen.dart';
import 'package:highwaypluss/screens/vehicle_form_screen.dart';
import 'package:highwaypluss/screens/success_screen.dart';
import 'package:highwaypluss/screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

// Root widget of the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HighwayPlus',  // Title of your app
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',  // Define the initial route
      routes: {
        '/': (context) => SplashScreen(),  // Splash screen as the initial route
        '/login': (context) => LoginScreen(),  // Login screen route
        '/vehicleForm': (context) => VehicleFormScreen(),  // Vehicle form route
        '/success': (context) => SuccessScreen(),  // Success screen route
        '/profile': (context) => ProfileScreen(
          ownerName: 'John Doe',  // Example data
          vehicleRegNo: 'MH12AB1234',  // Example data
          licenceNo: 'DL1234567890',  // Example data
          vehicleType: 'Car',  // Example data
          manufacturer: 'Toyota',  // Example data
          model: 'Corolla',  // Example data
        ),  // Profile screen route
      },
    );
  }
}

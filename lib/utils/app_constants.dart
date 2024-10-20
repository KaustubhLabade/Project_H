import 'package:flutter/material.dart';

class AppConstants {
  // API Base URL
  static const String apiBaseUrl = 'https://your-backend-api.com/api'; // Replace with your backend URL

  // API Endpoints
  static const String sendOtpEndpoint = '$apiBaseUrl/send-otp';
  static const String verifyOtpEndpoint = '$apiBaseUrl/verify-otp';
  static const String addVehicleEndpoint = '$apiBaseUrl/vehicles';
  static const String fetchVehiclesEndpoint = '$apiBaseUrl/vehicles';
  static const String updateVehicleEndpoint = '$apiBaseUrl/vehicles'; // Will append vehicle ID dynamically
  static const String deleteVehicleEndpoint = '$apiBaseUrl/vehicles'; // Will append vehicle ID dynamically
  static const String registerUserEndpoint = '$apiBaseUrl/register';

  // App-wide strings
  static const String appName = 'Highway Plus App';
  static const String welcomeMessage = 'Welcome to Highway Plus!';
  static const String loginToContinue = 'Login to Continue';
  static const String otpVerificationTitle = 'OTP Verification';
  static const String vehicleFormTitle = 'Vehicle Registration';
  static const String membershipTitle = 'Get Membership';
  static const String confirmOwnership = 'Are you a vehicle owner?';

  // Color Palette
  static const Color primaryColor = Colors.blueAccent;
  static const Color accentColor = Colors.black87;
  static const Color backgroundColor = Colors.black;
  static const Color buttonColor = Colors.blueAccent;
  static const Color cardColor = Colors.grey;
  static const Color inputFieldColor = Colors.black54;

  // Gradient colors for overlays (use dynamic colors)
  static final List<Color> gradientOverlayColors = [
    Colors.black.withOpacity(0.2),
    Colors.black.withOpacity(0.7),
  ];

  // Text Styles
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.white70,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Input field decoration style
  static const InputDecoration inputFieldDecoration = InputDecoration(
    border: OutlineInputBorder(),
    filled: true,
    fillColor: Colors.black54,
    labelStyle: TextStyle(color: Colors.white),
    prefixIconColor: Colors.white,
  );

  // Padding values
  static const double defaultPadding = 16.0;
  static const double cardElevation = 5.0;

  // Default image paths
  static const String defaultBackgroundImage = 'assets/images/background.jpg';
  static const String defaultLogoImage = 'assets/images/logo.png';

  // Error messages
  static const String phoneNumberError = 'Please enter a valid phone number';
  static const String otpError = 'Invalid OTP!';
  static const String vehicleNumberError = 'Please enter a valid vehicle registration number';

  // Membership plans
  static const int oneDayMembershipPrice = 33;
  static const int monthlyMembershipPrice = 99;
}

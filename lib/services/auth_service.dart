import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String _baseUrl = 'https://your-backend-api.com/api'; // Replace with your backend URL

  // Method to send OTP to the given phone number
  Future<bool> sendOtp(String phoneNumber) async {
    final url = Uri.parse('$_baseUrl/send-otp');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phoneNumber': phoneNumber}),
      );

      if (response.statusCode == 200) {
        return true; // OTP sent successfully
      } else {
        print('Failed to send OTP: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error while sending OTP: $e');
      return false;
    }
  }

  // Method to verify OTP
  Future<bool> verifyOtp(String phoneNumber, String otp) async {
    final url = Uri.parse('$_baseUrl/verify-otp');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phoneNumber': phoneNumber, 'otp': otp}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Save user session/token if needed
        // Example: saveToken(data['token']);
        return true; // OTP verified successfully
      } else {
        print('Failed to verify OTP: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error while verifying OTP: $e');
      return false;
    }
  }

  // Method to register a new user (if needed)
  Future<bool> registerUser(String phoneNumber, String name) async {
    final url = Uri.parse('$_baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phoneNumber': phoneNumber, 'name': name}),
      );

      if (response.statusCode == 200) {
        return true; // User registered successfully
      } else {
        print('Failed to register user: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error while registering user: $e');
      return false;
    }
  }

  // Method to log out user (clear user session)
  Future<void> logout(BuildContext context) async {
    // Clear stored session/token (if used)
    // Example: clearToken();
    // Navigate to the login screen
    Navigator.pushReplacementNamed(context, '/');
  }

  // Optional: Save token locally (using shared_preferences or any local storage)
  Future<void> saveToken(String token) async {
    // Save token locally
    // Example using shared_preferences:
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString('authToken', token);
  }

  // Optional: Retrieve token
  Future<String?> getToken() async {
    // Retrieve token
    // Example using shared_preferences:
    // final prefs = await SharedPreferences.getInstance();
    // return prefs.getString('authToken');
  }

  // Optional: Clear token
  Future<void> clearToken() async {
    // Clear token
    // Example using shared_preferences:
    // final prefs = await SharedPreferences.getInstance();
    // prefs.remove('authToken');
  }
}

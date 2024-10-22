import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String _baseUrl = 'https://projecthighwayplus-1.onrender.com'; // Backend base URL

  // Method to send OTP to the given phone number
  // API Endpoint: GET /authenticate/request-otp?phone=PHONE_NUMBER
  // This endpoint sends an OTP to the user's phone number.
  Future<bool> sendOtp(String phoneNumber) async {
    final url = Uri.parse('$_baseUrl/authenticate/request-otp?phone=$phoneNumber');
    try {
      final response = await http.get(url);

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
  // API Endpoint: GET /authenticate/verify-otp?phone=PHONE_NUMBER&otp=OTP
  // This endpoint verifies the OTP sent to the user's phone number.
  Future<bool> verifyOtp(String phoneNumber, String otp) async {
    final url = Uri.parse('$_baseUrl/authenticate/verify-otp?phone=$phoneNumber&otp=$otp');
    try {
      final response = await http.get(url);

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

  // Method to resend OTP
  // API Endpoint: GET /authenticate/resend-otp?phone=PHONE_NUMBER
  // This endpoint resends the OTP to the user's phone number.
  Future<bool> resendOtp(String phoneNumber) async {
    final url = Uri.parse('$_baseUrl/authenticate/resend-otp?phone=$phoneNumber');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return true; // OTP resent successfully
      } else {
        print('Failed to resend OTP: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error while resending OTP: $e');
      return false;
    }
  }

  // Method to register a new user
  // API Endpoint: POST /personal-info/register
  // This endpoint registers the user's personal information including phone, name, and ID details.
  Future<bool> registerUser(String phoneNumber, String name, String idDetails) async {
    final url = Uri.parse('$_baseUrl/personal-info/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': phoneNumber,
          'name': name,
          'idDetails': idDetails,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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

import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;

  // Getter for loading state
  bool get isLoading => _isLoading;

  // Getter for error message
  String? get errorMessage => _errorMessage;

  // Method to send OTP
  Future<void> sendOtp(String phoneNumber) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      bool success = await _authService.sendOtp(phoneNumber);
      if (!success) {
        _errorMessage = 'Failed to send OTP.';
      }
    } catch (e) {
      _errorMessage = 'Error while sending OTP: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to verify OTP
  Future<void> verifyOtp(String phoneNumber, String otp) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      bool success = await _authService.verifyOtp(phoneNumber, otp);
      if (!success) {
        _errorMessage = 'OTP verification failed.';
      }
    } catch (e) {
      _errorMessage = 'Error while verifying OTP: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to register a user
  Future<void> registerUser(String phoneNumber, String name, String idDetails) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      bool success = await _authService.registerUser(phoneNumber, name, idDetails);
      if (!success) {
        _errorMessage = 'Failed to register user.';
      }
    } catch (e) {
      _errorMessage = 'Error while registering user: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to log out the user
  Future<void> logout(BuildContext context) async {
    await _authService.logout(context);
    notifyListeners();
  }
}

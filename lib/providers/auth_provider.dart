import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  // State variables
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _authToken;
  String? _phoneNumber;
  String? _errorMessage;

  // Getters
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get authToken => _authToken;
  String? get phoneNumber => _phoneNumber;
  String? get errorMessage => _errorMessage;

  // Method to send OTP
  Future<bool> sendOtp(String phoneNumber) async {
    _setLoading(true);
    _clearError();

    try {
      bool result = await _authService.sendOtp(phoneNumber);
      if (result) {
        _phoneNumber = phoneNumber;
        notifyListeners();
        return true;
      } else {
        _setError('Failed to send OTP. Please try again.');
        return false;
      }
    } catch (e) {
      _setError('Error while sending OTP: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Method to verify OTP
  Future<bool> verifyOtp(String otp) async {
    if (_phoneNumber == null) {
      _setError('Phone number is not set.');
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      bool result = await _authService.verifyOtp(_phoneNumber!, otp);
      if (result) {
        _isAuthenticated = true;
        notifyListeners();
        return true;
      } else {
        _setError('Invalid OTP. Please check and try again.');
        return false;
      }
    } catch (e) {
      _setError('Error while verifying OTP: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Method to register a user (if needed)
  Future<bool> registerUser(String name) async {
    if (_phoneNumber == null) {
      _setError('Phone number is not set.');
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      bool result = await _authService.registerUser(_phoneNumber!, name);
      if (result) {
        notifyListeners();
        return true;
      } else {
        _setError('Failed to register user. Please try again.');
        return false;
      }
    } catch (e) {
      _setError('Error while registering user: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Method to log out user
  Future<void> logout(BuildContext context) async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.logout(context);
      _isAuthenticated = false;
      _authToken = null;
      _phoneNumber = null;
      notifyListeners();
    } catch (e) {
      _setError('Error while logging out: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Method to clear error message
  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Private method to set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Private method to set error message
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}

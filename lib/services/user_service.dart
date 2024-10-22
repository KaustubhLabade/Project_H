import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  static const String _baseUrl = 'https://projecthighwayplus-1.onrender.com'; // Your backend URL

  // Method to fetch user details by phone number
  // API Endpoint: GET /personal-info?phone=PHONE_NUMBER
  // This endpoint retrieves user details based on the provided phone number.
  Future<Map<String, dynamic>?> fetchUserDetails(String phoneNumber) async {
    final url = Uri.parse('$_baseUrl/personal-info?phone=$phoneNumber');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> userDetails = jsonDecode(response.body);
        return userDetails; // Return user details
      } else {
        print('Failed to fetch user details: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error while fetching user details: $e');
      return null;
    }
  }

  // Method to update user details
  // API Endpoint: PUT /personal-info/update
  // This endpoint updates the user information based on the provided details (phone, name, ID details).
  Future<bool> updateUserDetails({
    required String phoneNumber,
    required String name,
    required String idDetails,
  }) async {
    final url = Uri.parse('$_baseUrl/personal-info/update');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': phoneNumber,
          'name': name,
          'idDetails': idDetails,
        }),
      );

      if (response.statusCode == 200) {
        return true; // User details updated successfully
      } else {
        print('Failed to update user details: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error while updating user details: $e');
      return false;
    }
  }

  // Method to delete user account
  // API Endpoint: DELETE /personal-info/delete?phone=PHONE_NUMBER
  // This endpoint deletes a user account based on the provided phone number.
  Future<bool> deleteUser(String phoneNumber) async {
    final url = Uri.parse('$_baseUrl/personal-info/delete?phone=$phoneNumber');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return true; // User deleted successfully
      } else {
        print('Failed to delete user: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error while deleting user: $e');
      return false;
    }
  }

  // Method to register user
  // API Endpoint: POST /personal-info/register
  // This endpoint registers a new user with the given phone number, name, and ID details.
  Future<bool> registerUser({
    required String phoneNumber,
    required String name,
    required String idDetails,
  }) async {
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
}

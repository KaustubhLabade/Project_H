import 'package:http/http.dart' as http;
import 'dart:convert';

class VehicleService {
  static const String _baseUrl = 'https://your-backend-api.com/api'; // Replace with your backend URL

  // Method to add a new vehicle
  Future<bool> addVehicle({
    required String ownerName,
    required String vehicleRegNo,
    required String licenceNo,
    required String vehicleType,
    required String manufacturer,
    required String model,
    required String licensePhoto,
    required String rcPhoto,
  }) async {
    final url = Uri.parse('$_baseUrl/vehicles');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'ownerName': ownerName,
          'vehicleRegNo': vehicleRegNo,
          'licenceNo': licenceNo,
          'vehicleType': vehicleType,
          'manufacturer': manufacturer,
          'model': model,
          'licensePhoto': licensePhoto,
          'rcPhoto': rcPhoto,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true; // Vehicle added successfully
      } else {
        print('Failed to add vehicle: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error while adding vehicle: $e');
      return false;
    }
  }

  // Method to fetch a list of vehicles for a specific owner
  Future<List<Map<String, dynamic>>?> fetchVehicles(String ownerId) async {
    final url = Uri.parse('$_baseUrl/vehicles?ownerId=$ownerId');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> vehicles = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        return vehicles; // Return the list of vehicles
      } else {
        print('Failed to fetch vehicles: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error while fetching vehicles: $e');
      return null;
    }
  }

  // Method to update a vehicle's information
  Future<bool> updateVehicle({
    required String vehicleId,
    required String ownerName,
    required String vehicleRegNo,
    required String licenceNo,
    required String vehicleType,
    required String manufacturer,
    required String model,
  }) async {
    final url = Uri.parse('$_baseUrl/vehicles/$vehicleId');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'ownerName': ownerName,
          'vehicleRegNo': vehicleRegNo,
          'licenceNo': licenceNo,
          'vehicleType': vehicleType,
          'manufacturer': manufacturer,
          'model': model,
        }),
      );

      if (response.statusCode == 200) {
        return true; // Vehicle updated successfully
      } else {
        print('Failed to update vehicle: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error while updating vehicle: $e');
      return false;
    }
  }

  // Method to delete a vehicle
  Future<bool> deleteVehicle(String vehicleId) async {
    final url = Uri.parse('$_baseUrl/vehicles/$vehicleId');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return true; // Vehicle deleted successfully
      } else {
        print('Failed to delete vehicle: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error while deleting vehicle: $e');
      return false;
    }
  }

  // Method to fetch details of a single vehicle
  Future<Map<String, dynamic>?> fetchVehicleDetails(String vehicleId) async {
    final url = Uri.parse('$_baseUrl/vehicles/$vehicleId');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> vehicle = jsonDecode(response.body);
        return vehicle; // Return the vehicle details
      } else {
        print('Failed to fetch vehicle details: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error while fetching vehicle details: $e');
      return null;
    }
  }
}

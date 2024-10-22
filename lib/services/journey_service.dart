import 'package:http/http.dart' as http;
import 'dart:convert';

class JourneyService {
  static const String _baseUrl = 'https://projecthighwayplus-1.onrender.com'; // Your backend URL

  // Fetch journeys for a specific vehicle
  // GET /vehicle-journey-history/show-vehicle-history?vehicleId={vehicleId}
  Future<List<Map<String, dynamic>>?> fetchJourneys(String vehicleId) async {
    final url = Uri.parse('$_baseUrl/vehicle-journey-history/show-vehicle-history?vehicleId=$vehicleId');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> journeys = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        return journeys;
      } else {
        print('Failed to fetch journeys: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error while fetching journeys: $e');
      return null;
    }
  }

  // Add a new journey
  // POST /vehicle-journey-history/journey
  Future<bool> addJourney({
    required String userId,
    required String vehicleId,
    required String startLocation,
    required String endLocation,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final url = Uri.parse('$_baseUrl/vehicle-journey-history/journey');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'vehicleId': vehicleId,
          'startLocation': startLocation,
          'endLocation': endLocation,
          'startTime': startTime.toIso8601String(),
          'endTime': endTime.toIso8601String(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print('Failed to add journey: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error while adding journey: $e');
      return false;
    }
  }

  // Update a journey's status
  // PUT /vehicle-journey-history/journey/{journeyId}/status
  Future<bool> updateJourneyStatus(String journeyId, String status) async {
    final url = Uri.parse('$_baseUrl/vehicle-journey-history/journey/$journeyId/status');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': status}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update journey status: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error while updating journey status: $e');
      return false;
    }
  }

  // Delete a journey
  // DELETE /vehicle-journey-history/journey/{journeyId}
  Future<bool> deleteJourney(String journeyId) async {
    final url = Uri.parse('$_baseUrl/vehicle-journey-history/journey/$journeyId');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to delete journey: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error while deleting journey: $e');
      return false;
    }
  }
}

import 'package:flutter/material.dart';
import '../services/journey_service.dart';

class JourneyProvider with ChangeNotifier {
  final JourneyService _journeyService = JourneyService();
  List<Map<String, dynamic>> _journeys = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getter for the list of journeys
  List<Map<String, dynamic>> get journeys => _journeys;

  // Getter for loading state
  bool get isLoading => _isLoading;

  // Getter for error message
  String? get errorMessage => _errorMessage;

  // Fetch all journeys from the service
  Future<void> fetchJourneys(String vehicleId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedJourneys = await _journeyService.fetchJourneys(vehicleId);
      if (fetchedJourneys != null) {
        _journeys = fetchedJourneys;
      } else {
        _errorMessage = 'Failed to fetch journeys.';
      }
    } catch (e) {
      _errorMessage = 'Error while fetching journeys: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new journey
  Future<void> addJourney({
    required String userId,
    required String vehicleId,
    required String startLocation,
    required String endLocation,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      bool success = await _journeyService.addJourney(
        userId: userId,
        vehicleId: vehicleId,
        startLocation: startLocation,
        endLocation: endLocation,
        startTime: startTime,
        endTime: endTime,
      );

      if (success) {
        // Fetch journeys again to update the list
        await fetchJourneys(vehicleId);
      } else {
        _errorMessage = 'Failed to add the journey.';
      }
    } catch (e) {
      _errorMessage = 'Error while adding journey: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update the status of an existing journey
  Future<void> updateJourneyStatus(String journeyId, String status, String vehicleId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      bool success = await _journeyService.updateJourneyStatus(journeyId, status);

      if (success) {
        // Fetch journeys again to reflect the status update
        await fetchJourneys(vehicleId);
      } else {
        _errorMessage = 'Failed to update the journey status.';
      }
    } catch (e) {
      _errorMessage = 'Error while updating journey status: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete a journey
  Future<void> deleteJourney(String journeyId, String vehicleId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      bool success = await _journeyService.deleteJourney(journeyId);

      if (success) {
        // Fetch journeys again to remove the deleted one from the list
        await fetchJourneys(vehicleId);
      } else {
        _errorMessage = 'Failed to delete the journey.';
      }
    } catch (e) {
      _errorMessage = 'Error while deleting journey: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

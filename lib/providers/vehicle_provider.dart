import 'package:flutter/material.dart';
import '../services/vehicle_service.dart';

class VehicleProvider with ChangeNotifier {
  final VehicleService _vehicleService = VehicleService();

  // State variables
  bool _isLoading = false;
  String? _errorMessage;
  List<Map<String, dynamic>> _vehicles = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Map<String, dynamic>> get vehicles => _vehicles;

  // Method to fetch all vehicles without userId
  Future<void> fetchVehicles() async {
    _setLoading(true);
    _clearError();

    try {
      List<Map<String, dynamic>>? fetchedVehicles = await _vehicleService.fetchVehicles(AutofillHints.username);
      if (fetchedVehicles != null) {
        _vehicles = fetchedVehicles;
        notifyListeners();
      } else {
        _setError('Failed to fetch vehicles.');
      }
    } catch (e) {
      _setError('Error while fetching vehicles: $e');
    } finally {
      _setLoading(false);
    }
  }

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
    _setLoading(true);
    _clearError();

    try {
      bool result = await _vehicleService.addVehicle(
        ownerName: ownerName,
        vehicleRegNo: vehicleRegNo,
        licenceNo: licenceNo,
        vehicleType: vehicleType,
        manufacturer: manufacturer,
        model: model,
        licensePhoto: licensePhoto,
        rcPhoto: rcPhoto,
      );

      if (result) {
        await fetchVehicles(); // Fetch the updated list of vehicles
        return true;
      } else {
        _setError('Failed to add vehicle. Please try again.');
        return false;
      }
    } catch (e) {
      _setError('Error while adding vehicle: $e');
      return false;
    } finally {
      _setLoading(false);
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
    _setLoading(true);
    _clearError();

    try {
      bool result = await _vehicleService.updateVehicle(
        vehicleId: vehicleId,
        ownerName: ownerName,
        vehicleRegNo: vehicleRegNo,
        licenceNo: licenceNo,
        vehicleType: vehicleType,
        manufacturer: manufacturer,
        model: model,
      );

      if (result) {
        await fetchVehicles(); // Fetch the updated list of vehicles
        return true;
      } else {
        _setError('Failed to update vehicle.');
        return false;
      }
    } catch (e) {
      _setError('Error while updating vehicle: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Method to delete a vehicle
  Future<bool> deleteVehicle(String vehicleId) async {
    _setLoading(true);
    _clearError();

    try {
      bool result = await _vehicleService.deleteVehicle(vehicleId);
      if (result) {
        await fetchVehicles(); // Fetch the updated list of vehicles
        return true;
      } else {
        _setError('Failed to delete vehicle.');
        return false;
      }
    } catch (e) {
      _setError('Error while deleting vehicle: $e');
      return false;
    } finally {
      _setLoading(false);
    }
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

  // Method to clear error message
  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

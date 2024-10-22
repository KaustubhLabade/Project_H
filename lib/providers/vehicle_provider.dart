import 'package:flutter/material.dart';
import '../services/vehicle_service.dart';

class VehicleProvider with ChangeNotifier {
  final VehicleService _vehicleService = VehicleService();
  List<Map<String, dynamic>> _vehicles = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getter for the list of vehicles
  List<Map<String, dynamic>> get vehicles => _vehicles;

  // Getter for loading state
  bool get isLoading => _isLoading;

  // Getter for error message
  String? get errorMessage => _errorMessage;

  // Fetch all vehicles from the service
  Future<void> fetchVehicles(String phoneNumber) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedVehicles = await _vehicleService.fetchVehicles(phoneNumber);
      if (fetchedVehicles != null) {
        _vehicles = fetchedVehicles;
      } else {
        _errorMessage = 'Failed to fetch vehicles.';
      }
    } catch (e) {
      _errorMessage = 'Error while fetching vehicles: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new vehicle
  Future<void> addVehicle({
    required String ownerName,
    required String vehicleRegNo,
    required String licenceNo,
    required String vehicleType,
    required String manufacturer,
    required String model,
    required String licensePhoto,
    required String rcPhoto,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      bool success = await _vehicleService.addVehicle(
        ownerName: ownerName,
        vehicleRegNo: vehicleRegNo,
        licenceNo: licenceNo,
        vehicleType: vehicleType,
        manufacturer: manufacturer,
        model: model,
        licensePhoto: licensePhoto,
        rcPhoto: rcPhoto,
      );

      if (success) {
        // Fetch vehicles again to update the list
        await fetchVehicles(ownerName);
      } else {
        _errorMessage = 'Failed to add the vehicle.';
      }
    } catch (e) {
      _errorMessage = 'Error while adding vehicle: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update an existing vehicle
  Future<void> updateVehicle({
    required String vehicleId,
    required String ownerName,
    required String vehicleRegNo,
    required String licenceNo,
    required String vehicleType,
    required String manufacturer,
    required String model,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      bool success = await _vehicleService.updateVehicle(
        vehicleId: vehicleId,
        ownerName: ownerName,
        vehicleRegNo: vehicleRegNo,
        licenceNo: licenceNo,
        vehicleType: vehicleType,
        manufacturer: manufacturer,
        model: model,
      );

      if (success) {
        // Fetch vehicles again to reflect the update
        await fetchVehicles(ownerName);
      } else {
        _errorMessage = 'Failed to update the vehicle.';
      }
    } catch (e) {
      _errorMessage = 'Error while updating vehicle: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete a vehicle
  Future<void> deleteVehicle(String vehicleId, String ownerName) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      bool success = await _vehicleService.deleteVehicle(vehicleId);

      if (success) {
        // Fetch vehicles again to remove the deleted one from the list
        await fetchVehicles(ownerName);
      } else {
        _errorMessage = 'Failed to delete the vehicle.';
      }
    } catch (e) {
      _errorMessage = 'Error while deleting vehicle: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:highwaypluss/widgets/custom_button.dart';
import 'package:highwaypluss/widgets/form_field.dart'; // Import the custom widgets

class VehicleFormScreen extends StatefulWidget {
  @override
  _VehicleFormScreenState createState() => _VehicleFormScreenState();
}

class _VehicleFormScreenState extends State<VehicleFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers for the input fields
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController vehicleRegNoController = TextEditingController();
  final TextEditingController licenceNoController = TextEditingController();
  final TextEditingController vehicleTypeController = TextEditingController();
  final TextEditingController manufacturerController = TextEditingController();
  final TextEditingController modelController = TextEditingController();

  GoogleMapController? mapController;
  LatLng? _initialPosition;  // User's initial position
  LatLng? _selectedDestination;  // Selected destination point
  double? _distance;  // Distance from initial point to destination

  @override
  void initState() {
    super.initState();
    _getUserLocation();  // Fetch user location when screen is loaded
  }

  // Get user's current location
  Future<void> _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  // Calculate distance between two LatLng points
  void _calculateDistance() {
    if (_initialPosition != null && _selectedDestination != null) {
      double distanceInMeters = Geolocator.distanceBetween(
        _initialPosition!.latitude,
        _initialPosition!.longitude,
        _selectedDestination!.latitude,
        _selectedDestination!.longitude,
      );
      setState(() {
        _distance = distanceInMeters / 1000;  // Convert to kilometers
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Registration and Journey'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Form fields for vehicle and owner details using CustomFormField
              CustomFormField(
                labelText: 'Owner Name',
                controller: ownerNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter owner name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              CustomFormField(
                labelText: 'Vehicle Registration No',
                controller: vehicleRegNoController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter vehicle registration number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              CustomFormField(
                labelText: 'Licence No',
                controller: licenceNoController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter licence number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              CustomFormField(
                labelText: 'Vehicle Type',
                controller: vehicleTypeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter vehicle type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              CustomFormField(
                labelText: 'Manufacturer',
                controller: manufacturerController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter manufacturer name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              CustomFormField(
                labelText: 'Model',
                controller: modelController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter model';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Google Maps Display
              Container(
                height: 300,
                child: _initialPosition == null
                    ? Center(child: CircularProgressIndicator())
                    : GoogleMap(
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition!,
                    zoom: 14,
                  ),
                  onTap: (LatLng position) {
                    setState(() {
                      _selectedDestination = position;
                    });
                  },
                  markers: _selectedDestination != null
                      ? {
                    Marker(
                      markerId: MarkerId('destination'),
                      position: _selectedDestination!,
                      infoWindow: InfoWindow(title: 'Selected Destination'),
                    )
                  }
                      : {},
                ),
              ),
              SizedBox(height: 20),

              // Distance Display
              _distance != null
                  ? Text(
                'Distance: ${_distance!.toStringAsFixed(2)} km',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
                  : Container(),

              // Custom Start Journey Button
              CustomButton(
                text: 'Start Journey',
                color: Colors.blueAccent,
                onPressed: () {
                  if (_selectedDestination != null) {
                    _calculateDistance();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a destination on the map')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

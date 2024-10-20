import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:highwaypluss/widgets/custom_button.dart';
import 'package:highwaypluss/widgets/form_field.dart';
import '../providers/vehicle_provider.dart';
import 'map_screen.dart';

class VehicleFormScreen extends StatefulWidget {
  @override
  _VehicleFormScreenState createState() => _VehicleFormScreenState();
}

class _VehicleFormScreenState extends State<VehicleFormScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Text controllers for the input fields
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController vehicleRegNoController = TextEditingController();
  final TextEditingController licenceNoController = TextEditingController();
  final TextEditingController vehicleTypeController = TextEditingController();
  final TextEditingController manufacturerController = TextEditingController();
  final TextEditingController modelController = TextEditingController();

  // Image variables for License and RC photos
  File? licensePhoto;
  File? rcPhoto;

  List<Map<String, String>> _vehicles = []; // List to hold multiple vehicles
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    ownerNameController.dispose();
    vehicleRegNoController.dispose();
    licenceNoController.dispose();
    vehicleTypeController.dispose();
    manufacturerController.dispose();
    modelController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source, String type) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        if (type == 'License') {
          licensePhoto = File(image.path);
        } else if (type == 'RC') {
          rcPhoto = File(image.path);
        }
      });
    }
  }

  void _addVehicle() {
    setState(() {
      _vehicles.add({
        'ownerName': ownerNameController.text,
        'vehicleRegNo': vehicleRegNoController.text,
        'vehicleType': vehicleTypeController.text,
        'manufacturer': manufacturerController.text,
        'model': modelController.text,
      });

      // Clear fields for next entry
      ownerNameController.clear();
      vehicleRegNoController.clear();
      vehicleTypeController.clear();
      manufacturerController.clear();
      modelController.clear();

      // Restart the animation for the new entry
      _controller.forward(from: 0);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (licensePhoto == null || rcPhoto == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please upload both License and RC photos.')),
        );
        return;
      }

      if (_vehicles.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please add at least one vehicle.')),
        );
        return;
      }

      // Use the vehicle provider to submit the vehicle information
      final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);

      // Loop through the list of vehicles to add them
      for (var vehicle in _vehicles) {
        vehicleProvider.addVehicle(
          ownerName: vehicle['ownerName']!,
          vehicleRegNo: vehicle['vehicleRegNo']!,
          licenceNo: licenceNoController.text,
          vehicleType: vehicle['vehicleType']!,
          manufacturer: vehicle['manufacturer']!,
          model: vehicle['model']!,
          licensePhoto: licensePhoto!.path,
          rcPhoto: rcPhoto!.path,
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vehicles registered successfully!')),
      );

      // Navigate to the home screen after successful submission
      Navigator.pushReplacementNamed(context, '/homeScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Registration'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildSectionTitle('User Verification'),
                SizedBox(height: 10),
                _buildPhotoUploadSection('Upload License Photo', licensePhoto, 'License'),
                SizedBox(height: 20),
                _buildPhotoUploadSection('Upload RC Photo', rcPhoto, 'RC'),
                SizedBox(height: 30),
                _buildSectionTitle('Owner and Vehicle Details'),
                SizedBox(height: 10),
                _buildCard(CustomFormField(
                  labelText: 'Owner Name',
                  controller: ownerNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter owner name';
                    }
                    return null;
                  },
                )),
                SizedBox(height: 20),
                _buildCard(CustomFormField(
                  labelText: 'Vehicle Registration No',
                  controller: vehicleRegNoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter vehicle registration number';
                    }
                    return null;
                  },
                )),
                SizedBox(height: 20),
                _buildCard(CustomFormField(
                  labelText: 'Vehicle Type',
                  controller: vehicleTypeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter vehicle type';
                    }
                    return null;
                  },
                )),
                SizedBox(height: 20),
                _buildCard(CustomFormField(
                  labelText: 'Manufacturer',
                  controller: manufacturerController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter manufacturer name';
                    }
                    return null;
                  },
                )),
                SizedBox(height: 20),
                _buildCard(CustomFormField(
                  labelText: 'Model',
                  controller: modelController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter model';
                    }
                    return null;
                  },
                )),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addVehicle,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Add Vehicle', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 20),
                if (_vehicles.isNotEmpty) ...[
                  _buildSectionTitle('Registered Vehicles'),
                  SizedBox(height: 10),
                  ..._vehicles.map((vehicle) {
                    return SlideTransition(
                      position: _slideAnimation,
                      child: _buildVehicleCard(vehicle),
                    );
                  }).toList(),
                ],
                SizedBox(height: 30),
                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoUploadSection(String title, File? image, String type) {
    return _buildCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 10),
          image == null
              ? Text("No photo selected.", style: TextStyle(color: Colors.white))
              : Image.file(image, height: 100, width: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery, type),
                icon: Icon(Icons.photo),
                label: Text("From Gallery"),
              ),
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera, type),
                icon: Icon(Icons.camera),
                label: Text("Take Photo"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleCard(Map<String, String> vehicle) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Owner: ${vehicle['ownerName']}',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Reg No: ${vehicle['vehicleRegNo']}',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 5),
            Text(
              'Type: ${vehicle['vehicleType']}',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 5),
            Text(
              'Manufacturer: ${vehicle['manufacturer']}',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 5),
            Text(
              'Model: ${vehicle['model']}',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildCard(Widget child) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}

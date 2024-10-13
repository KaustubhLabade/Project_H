import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:highwaypluss/widgets/custom_button.dart';
import 'package:highwaypluss/widgets/form_field.dart';  // Import the custom widgets
import 'map_screen.dart';  // Import the map screen for selecting destination

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

  // Image variables for License and RC photos
  File? licensePhoto;
  File? rcPhoto;

  LatLng? _selectedDestination;

  // Function to pick an image
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Registration'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: Colors.black, // Set background color to black
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildSectionTitle('Owner and Vehicle Details'),
                SizedBox(height: 10),

                // Owner Name Field
                _buildCard(
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
                ),
                SizedBox(height: 20),

                // Vehicle Registration Number Field
                _buildCard(
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
                ),
                SizedBox(height: 20),

                // License Number Field
                _buildCard(
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
                ),
                SizedBox(height: 20),

                // Vehicle Type Field
                _buildCard(
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
                ),
                SizedBox(height: 20),

                // Manufacturer Field
                _buildCard(
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
                ),
                SizedBox(height: 20),

                // Model Field
                _buildCard(
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
                ),
                SizedBox(height: 20),

                _buildSectionTitle('Upload Photos'),
                SizedBox(height: 10),

                // License Photo Upload Section
                _buildCard(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Upload License Photo", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 10),
                      licensePhoto == null
                          ? Text("No license photo selected.", style: TextStyle(color: Colors.white))
                          : Image.file(licensePhoto!, height: 100, width: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _pickImage(ImageSource.gallery, 'License'),
                            icon: Icon(Icons.photo),
                            label: Text("From Gallery"),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _pickImage(ImageSource.camera, 'License'),
                            icon: Icon(Icons.camera),
                            label: Text("Take Photo"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // RC Photo Upload Section
                _buildCard(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Upload RC Photo", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 10),
                      rcPhoto == null
                          ? Text("No RC photo selected.", style: TextStyle(color: Colors.white))
                          : Image.file(rcPhoto!, height: 100, width: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _pickImage(ImageSource.gallery, 'RC'),
                            icon: Icon(Icons.photo),
                            label: Text("From Gallery"),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _pickImage(ImageSource.camera, 'RC'),
                            icon: Icon(Icons.camera),
                            label: Text("Take Photo"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                _buildSectionTitle('Journey Destination'),
                SizedBox(height: 10),

                // Select Destination Button
                ElevatedButton(
                  onPressed: () async {
                    // Navigate to MapScreen to select a destination
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapScreen()),
                    );
                    if (result != null) {
                      setState(() {
                        _selectedDestination = result;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _selectedDestination == null
                        ? 'Select Destination'
                        : 'Destination Selected',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),

                // Show selected destination if available
                _selectedDestination != null
                    ? Text(
                  'Selected Destination: (${_selectedDestination!.latitude}, ${_selectedDestination!.longitude})',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                )
                    : Container(),

                // Custom Submit Button
                CustomButton(
                  text: 'Submit',
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle form submission
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Vehicle registered successfully!')),
                      );

                      // Navigate to Home Screen after submission
                      Navigator.pushReplacementNamed(context, '/homeScreen');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build section titles
  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  // Helper method to build a card widget for form fields and photo upload
  Widget _buildCard(Widget child) {
    return Card(
      color: Colors.grey[850],  // Card background dark color
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}

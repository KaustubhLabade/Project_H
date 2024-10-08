import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

  File? rcPhoto;
  File? licencePhoto;

  Future<void> pickImage(ImageSource source, String type) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    setState(() {
      if (type == "RC") {
        rcPhoto = File(image!.path);
      } else {
        licencePhoto = File(image!.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Registration'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Owner Name
              _buildTextField('Owner Name', ownerNameController),
              SizedBox(height: 20),

              // Vehicle Registration Number
              _buildTextField('Vehicle Registration No', vehicleRegNoController),
              SizedBox(height: 20),

              // Licence Number
              _buildTextField('Licence No', licenceNoController),
              SizedBox(height: 20),

              // Vehicle Type
              _buildTextField('Vehicle Type', vehicleTypeController),
              SizedBox(height: 20),

              // Manufacturer
              _buildTextField('Manufacturer', manufacturerController),
              SizedBox(height: 20),

              // Model
              _buildTextField('Model', modelController),
              SizedBox(height: 20),

              // RC Photo Upload Section
              _buildImageUploadSection('Upload RC Photo', rcPhoto, 'RC'),
              SizedBox(height: 20),

              // Licence Photo Upload Section
              _buildImageUploadSection('Upload Licence Photo', licencePhoto, 'Licence'),
              SizedBox(height: 40),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitForm();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Submit', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable method for building text fields
  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  // Reusable method for image upload section
  Widget _buildImageUploadSection(String label, File? imageFile, String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        imageFile == null
            ? Text('No $label selected.')
            : Image.file(imageFile, height: 100, width: 100, fit: BoxFit.cover),
        SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () => pickImage(ImageSource.gallery, type),
          icon: Icon(Icons.photo),
          label: Text('Upload from Gallery'),
        ),
        ElevatedButton.icon(
          onPressed: () => pickImage(ImageSource.camera, type),
          icon: Icon(Icons.camera_alt),
          label: Text('Take a Photo'),
        ),
      ],
    );
  }

  // Simulate form submission
  void _submitForm() {
    print('Form submitted');
    // Here you can send form data to your backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Vehicle Registered Successfully')),
    );
  }
}

import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String? phoneNumber = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Foreground content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // OTP Information
                  Text(
                    phoneNumber != null
                        ? 'Enter the OTP sent to $phoneNumber'
                        : 'No phone number provided!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,  // White text for contrast
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  // OTP Input Field
                  TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,  // Assuming OTP is 6 digits
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Enter OTP',
                      labelStyle: TextStyle(color: Colors.white),  // White label text
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.5),  // Slight transparency
                      counterText: '',  // Hide the counter for maxLength
                    ),
                  ),
                  SizedBox(height: 20),

                  // Verify OTP Button
                  ElevatedButton(
                    onPressed: () {
                      if (_verifyOtp(otpController.text)) {
                        _checkVehicleRegistration();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Invalid OTP!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Verify OTP', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _verifyOtp(String otp) {
    // Simulate OTP verification (in a real app, you would call an API)
    return otp == "123456";  // Replace with your actual OTP validation logic
  }

  void _checkVehicleRegistration() {
    // Simulate checking whether the vehicle is registered
    bool isVehicleRegistered = _isVehicleRegistered();

    if (isVehicleRegistered) {
      // Navigate to Home Screen if vehicle is registered
      Navigator.pushReplacementNamed(context, '/homeScreen');
    } else {
      // Navigate to Vehicle Form Screen if vehicle is not registered
      Navigator.pushReplacementNamed(context, '/vehicleFormScreen');
    }
  }

  bool _isVehicleRegistered() {
    // Simulate a check (in a real app, you'd fetch this from a backend or database)
    return false;  // For testing purposes, vehicle is not registered
  }
}

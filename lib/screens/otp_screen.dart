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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true, // To allow the background image to extend behind the AppBar
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
                  // Title
                  Text(
                    'OTP Verification',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),

                  // OTP Information
                  Text(
                    phoneNumber != null
                        ? 'Enter the OTP sent to $phoneNumber'
                        : 'No phone number provided!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),

                  // OTP Input Field
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6, // Assuming OTP is 6 digits
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      decoration: InputDecoration(
                        counterText: '', // Hide the counter for maxLength
                        labelText: 'Enter OTP',
                        labelStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

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
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Verify OTP',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Resend OTP Option
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('OTP Resent!')),
                      );
                    },
                    child: Text(
                      'Resend OTP',
                      style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8)),
                    ),
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
    return otp == "123456"; // Replace with your actual OTP validation logic
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
    return false; // For testing purposes, vehicle is not registered
  }
}

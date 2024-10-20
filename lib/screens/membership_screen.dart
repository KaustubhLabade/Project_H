import 'package:flutter/material.dart';
import 'subscription_screen.dart'; // Import the SubscriptionScreen

class MembershipScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Membership'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'), // Ensure this image exists
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.2), Colors.black.withOpacity(0.8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose Your Membership Plan',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),

                // Plan Options
                _buildPlanCard(
                  context,
                  '1-Day Membership',
                  33,
                  '₹33 for 1 Day Access',
                ),
                SizedBox(height: 20),
                _buildPlanCard(
                  context,
                  'Monthly Membership',
                  999,
                  '₹999 for 1 Month Access',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build a membership plan card
  Widget _buildPlanCard(BuildContext context, String planName, int amount, String description) {
    return GestureDetector(
      onTap: () {
        // Navigate to the SubscriptionScreen when a plan is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubscriptionScreen(
              planName: planName,
              planAmount: amount,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                planName,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

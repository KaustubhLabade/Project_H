import 'package:flutter/material.dart';

class JourneyHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journey History'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildJourneyCard('Journey 1', '12 March 2023', '10 km', 'New York to Brooklyn'),
            _buildJourneyCard('Journey 2', '5 April 2023', '25 km', 'Los Angeles to Santa Monica'),
            _buildJourneyCard('Journey 3', '18 May 2023', '50 km', 'San Francisco to San Jose'),
          ],
        ),
      ),
    );
  }

  // Helper method to build a journey card
  Widget _buildJourneyCard(String journeyName, String date, String distance, String route) {
    return Card(
      color: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              journeyName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Date: $date',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              'Distance: $distance',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              'Route: $route',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

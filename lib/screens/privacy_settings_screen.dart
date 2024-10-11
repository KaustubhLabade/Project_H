import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatefulWidget {
  @override
  _PrivacySettingsScreenState createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _locationAccess = true;
  bool _dataSharing = false;
  bool _profileVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location Access Switch
            SwitchListTile(
              title: Text('Location Access'),
              subtitle: Text('Allow app to access your location'),
              value: _locationAccess,
              onChanged: (value) {
                setState(() {
                  _locationAccess = value;
                });
              },
              secondary: Icon(Icons.location_on),
            ),
            Divider(),

            // Data Sharing Switch
            SwitchListTile(
              title: Text('Data Sharing'),
              subtitle: Text('Share anonymous data to improve the app'),
              value: _dataSharing,
              onChanged: (value) {
                setState(() {
                  _dataSharing = value;
                });
              },
              secondary: Icon(Icons.share),
            ),
            Divider(),

            // Profile Visibility Switch
            SwitchListTile(
              title: Text('Profile Visibility'),
              subtitle: Text('Allow others to view your profile'),
              value: _profileVisibility,
              onChanged: (value) {
                setState(() {
                  _profileVisibility = value;
                });
              },
              secondary: Icon(Icons.visibility),
            ),
            Divider(),

            // Save Changes Button
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _savePrivacySettings,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Save Changes', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  // Function to save privacy settings
  void _savePrivacySettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Privacy settings saved successfully!'),
      ),
    );

    // In a real app, you would send the updated privacy settings to the server or save locally
    // For now, we just show a message to indicate that changes have been "saved"
  }
}

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dark Mode Switch
            SwitchListTile(
              title: Text('Dark Mode'),
              subtitle: Text('Enable dark theme for the app'),
              value: _darkMode,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
              secondary: Icon(Icons.dark_mode),
            ),
            Divider(),

            // Notifications Toggle
            SwitchListTile(
              title: Text('Enable Notifications'),
              subtitle: Text('Receive notifications from the app'),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              secondary: Icon(Icons.notifications),
            ),
            Divider(),

            // Account Settings
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Account Settings'),
              subtitle: Text('Manage your account settings'),
              onTap: () {
                // Navigate to Account Settings Screen
                Navigator.pushNamed(context, '/accountSettingsScreen');
              },
            ),
            Divider(),

            // Privacy Settings
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Settings'),
              subtitle: Text('Manage your privacy settings'),
              onTap: () {
                // Navigate to Privacy Settings Screen
                Navigator.pushNamed(context, '/privacySettingsScreen');
              },
            ),
            Divider(),

            // About App
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About App'),
              subtitle: Text('Learn more about the app'),
              onTap: () {
                // Navigate to About Screen
                Navigator.pushNamed(context, '/aboutScreen');
              },
            ),
          ],
        ),
      ),
    );
  }
}

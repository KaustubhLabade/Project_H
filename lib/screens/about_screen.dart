import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  // Function to launch the URL
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Name
            Text(
              'Highway Plus',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // App Version
            Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),

            // App Description
            Text(
              'Highway Plus is a comprehensive vehicle management app that allows users to '
                  'easily register and manage their vehicles. It provides tools for vehicle '
                  'registration, owner profiles, and real-time data insights, making it perfect '
                  'for users who want to manage their vehicle-related tasks efficiently.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),

            // Company or App Website
            GestureDetector(
              onTap: () {
                _launchURL('https://example.com');  // Replace with your website URL
              },
              child: Text(
                'Visit our website',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 30),

            // License Information
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Licenses'),
              subtitle: Text('Open source licenses'),
              onTap: () {
                // Navigate to the License screen
                showLicensePage(
                  context: context,
                  applicationName: 'Highway Plus',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2024 Highway Plus Inc.',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

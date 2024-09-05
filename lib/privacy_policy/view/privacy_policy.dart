import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Introduction',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We are committed to protecting your privacy. This Privacy Policy explains how we handle your data and your rights concerning it. By using this app, you agree to the collection and use of information in accordance with this policy.',
            ),
            SizedBox(height: 20),
            Text(
              'Data Collection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'This app does not collect or store any personally identifiable information (PII). We do not track user behavior, location, or any other personal data. The information provided by this app is sourced from publicly available databases, and no user data is involved in the provision of these services.',
            ),
            SizedBox(height: 20),
            Text(
              'Third-Party Services',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'This app may link to external websites or services. These external sites have their own privacy policies. Please review their policies before interacting with them.',
            ),
            SizedBox(height: 20),
            Text(
              'Data Accuracy and Updates',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We aim to provide the most accurate information, but we cannot guarantee it will always be current or correct. Users should verify the emergency numbers with local authorities before using them in an emergency.',
            ),
            SizedBox(height: 20),
            Text(
              'Disclaimer of Liability',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We provide this app and its services on an "as is" basis and make no warranties about the information provided. We are not liable for any damages resulting from the use of this app.',
            ),
            SizedBox(height: 20),
            Text(
              'Security',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Although this app does not collect personal data, we take security seriously and protect communication between the app and its sources.',
            ),
            SizedBox(height: 20),
            Text(
              'Changes to Privacy Policy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We may update this policy from time to time. Your continued use of the app after changes signifies acceptance of the new terms.',
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'If you have any questions or concerns, please contact us at [your-email@example.com].',
            ),
          ],
        ),
      ),
    );
  }
}

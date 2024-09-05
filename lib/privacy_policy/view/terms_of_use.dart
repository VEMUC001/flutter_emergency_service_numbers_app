import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Use'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms of Use',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Acceptance of Terms',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'By using this app, you agree to these Terms of Use. If you do not agree, please do not use the app. We reserve the right to modify these terms at any time.',
            ),
            SizedBox(height: 20),
            Text(
              'Use of the App',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'This app is designed to provide emergency numbers for countries worldwide. You should verify the emergency numbers before relying on them in an emergency. We do not guarantee the accuracy or completeness of the information.',
            ),
            SizedBox(height: 20),
            Text(
              'No Guarantee of Accuracy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'While we strive to provide accurate information, we cannot guarantee that all information is current or correct. It is your responsibility to verify emergency contact numbers with local authorities.',
            ),
            SizedBox(height: 20),
            Text(
              'Limitation of Liability',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We disclaim any liability for damages or losses resulting from the use of this app. This includes direct or indirect damages arising from reliance on outdated or incorrect information.',
            ),
            SizedBox(height: 20),
            Text(
              'User Responsibility',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'You are solely responsible for verifying the accuracy of the emergency numbers provided. This app is intended as a supplementary tool and should not replace direct communication with local authorities.',
            ),
            SizedBox(height: 20),
            Text(
              'Intellectual Property',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'All content in this app, including the design, graphics, and text, is the property of [Your App Name] or its licensors. You may not reproduce or distribute the content without permission.',
            ),
            SizedBox(height: 20),
            Text(
              'Prohibited Use',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'You may not use this app for illegal purposes or in violation of any laws. Misusing the information provided for fraudulent activities is strictly prohibited.',
            ),
            SizedBox(height: 20),
            Text(
              'Termination of Access',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We reserve the right to terminate access to the app at any time, for any reason, including violations of these terms.',
            ),
            SizedBox(height: 20),
            Text(
              'Governing Law',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'These Terms of Use are governed by the laws of [Your Jurisdiction]. Any legal disputes will be settled in the courts of [Your Jurisdiction].',
            ),
            SizedBox(height: 20),
            Text(
              'Changes to Terms of Use',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We may modify these terms at any time. Continued use of the app after any changes signifies acceptance of the new terms.',
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

import 'package:emergency_service_numbers/home/view/emergency_services_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class EmergencyContactApp extends StatelessWidget {
  const EmergencyContactApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      home: EmergencyServicesPage(),
    );
  }
}

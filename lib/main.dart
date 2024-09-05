import 'package:emergency_service_numbers/application.dart';
import 'package:emergency_service_numbers/home/model/emergency_contact.dart';
import 'package:emergency_service_numbers/home/view_model/services/data_initialization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Hive.initFlutter();
  Hive.registerAdapter(EmergencyContactAdapter());

  final dataInitializationService = DataInitializationService();
  await dataInitializationService.initializaData();

  runApp(const ProviderScope(child: EmergencyContactApp()));
}

import 'dart:convert';

import 'package:emergency_service_numbers/home/model/emergency_contact.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class DataInitializationService {
  Future<void> initializaData() async {
    var box = await Hive.openBox<EmergencyContact>('emergencyContacts');

    if (box.isEmpty) {
      final String response =
          await rootBundle.loadString('assets/emergency_countries.json');
      final data = await jsonDecode(response);

      for (var item in data['data']) {
        final country = item['Country'];
        var contact = EmergencyContact(
          countryName: country['Name'],
          isoCode: country['ISOCode'],
          ambulance: _getFirstNumber(item['Ambulance']),
          fire: _getFirstNumber(item['Fire']),
          police: _getFirstNumber(item['Police']),
          dispatch: _getFirstNumber(item['Dispatch']),
          notes: _getNotes(item['Notes']),
        );

        await box.add(contact);
      }
    }
  }

  String _getFirstNumber(Map<String, dynamic> numbers) {
    if (numbers['All'] != null && numbers['All'].isNotEmpty) {
      return numbers['All'][0] ?? '';
    }
    return '';
  }

  String _getNotes(String? note) {
    if (note != null && note.isNotEmpty) {
      return note;
    }

    return '';
  }
}

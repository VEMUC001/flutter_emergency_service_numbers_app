// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'emergency_contact.g.dart';

@HiveType(typeId: 0)
class EmergencyContact extends HiveObject {
  @HiveField(0)
  final String countryName;

  @HiveField(1)
  final String isoCode;

  @HiveField(2)
  final String ambulance;

  @HiveField(3)
  final String fire;

  @HiveField(4)
  final String police;

  @HiveField(5)
  final String dispatch;

  @HiveField(6)
  final String? notes;

  EmergencyContact(
      {required this.countryName,
      required this.isoCode,
      required this.ambulance,
      required this.fire,
      required this.police,
      required this.dispatch,
      this.notes});

  EmergencyContact copyWith({
    String? countryName,
    String? isoCode,
    String? ambulance,
    String? fire,
    String? police,
    String? dispatch,
    String? notes,
  }) {
    return EmergencyContact(
      countryName: countryName ?? this.countryName,
      isoCode: isoCode ?? this.isoCode,
      ambulance: ambulance ?? this.ambulance,
      fire: fire ?? this.fire,
      police: police ?? this.police,
      dispatch: dispatch ?? this.dispatch,
      notes: notes ?? this.notes,
    );
  }
}

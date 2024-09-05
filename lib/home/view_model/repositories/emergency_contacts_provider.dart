// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:emergency_service_numbers/home/model/emergency_contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final emergencyContactsProvider =
    StateNotifierProvider<EmergencyContactsNotifier, EmergencyContactsState>(
        (ref) {
  return EmergencyContactsNotifier();
});

class EmergencyContactsState {
  final List<EmergencyContact> contacts;
  final EmergencyContact? selectedContact;

  EmergencyContactsState({
    required this.contacts,
    this.selectedContact,
  });

  EmergencyContactsState copyWith({
    List<EmergencyContact>? contacts,
    EmergencyContact? selectedContact,
  }) {
    return EmergencyContactsState(
      contacts: contacts ?? this.contacts,
      selectedContact: selectedContact ?? this.selectedContact,
    );
  }
}

class EmergencyContactsNotifier extends StateNotifier<EmergencyContactsState> {
  EmergencyContactsNotifier() : super(EmergencyContactsState(contacts: [])) {
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    var box = await Hive.openBox<EmergencyContact>('emergencyContacts');
    state = state.copyWith(contacts: box.values.toList());
  }

  void searchContact(String query) {
    if (query.isEmpty) {
      state = state.copyWith(selectedContact: null);
    } else {
      final selectedContact = state.contacts.firstWhere(
        (contact) =>
            contact.countryName.toLowerCase().contains(query.toLowerCase()),
        orElse: () => EmergencyContact(
            countryName: 'Not Found',
            isoCode: '',
            ambulance: '',
            fire: '',
            police: '',
            dispatch: '',
            notes: ''),
      );

      state = state.copyWith(selectedContact: selectedContact);
    }
  }

  Future<void> updateContactNumbers(
    EmergencyContact contact, {
    String? ambulance,
    String? fire,
    String? police,
    String? dispatch,
  }) async {
    var box = await Hive.openBox<EmergencyContact>('emergencyContacts');
    var updatedContact = EmergencyContact(
      countryName: contact.countryName,
      isoCode: contact.isoCode,
      ambulance: ambulance ?? contact.ambulance,
      fire: fire ?? contact.fire,
      police: police ?? contact.police,
      dispatch: dispatch ?? contact.dispatch,
      notes: contact.notes,
    );

    int contactIndex =
        state.contacts.indexWhere((c) => c.isoCode == contact.isoCode);
    if (contactIndex != -1) {
      await box.putAt(contactIndex, updatedContact);
      var updatedContacts = List<EmergencyContact>.from(state.contacts);
      updatedContacts[contactIndex] = updatedContact;
      state = state.copyWith(
        contacts: updatedContacts,
        selectedContact: state.selectedContact?.isoCode == contact.isoCode
            ? updatedContact
            : state.selectedContact,
      );
    }
  }
}

import 'package:emergency_service_numbers/home/model/emergency_contact.dart';
import 'package:emergency_service_numbers/home/view_model/repositories/emergency_contacts_provider.dart';
import 'package:emergency_service_numbers/privacy_policy/view/privacy_policy.dart';
import 'package:emergency_service_numbers/privacy_policy/view/terms_of_use.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyServicesPage extends ConsumerWidget {
  final FocusNode _searchFocusNode = FocusNode();

  EmergencyServicesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(emergencyContactsProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Emergency Contacts',
            style: TextStyle(fontSize: 18.0),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Privacy Policy',
                    child: Text('Privacy Policy'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Terms of Use',
                    child: Text('Terms of Use'),
                  ),
                ];
              },
              onSelected: (value) {
                switch (value) {
                  case 'Privacy Policy':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyPage()),
                    );
                  case 'Terms of Use':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermsOfUsePage()),
                    );
                }
              },
            )
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TypeAheadField<EmergencyContact>(
                focusNode: _searchFocusNode,
                loadingBuilder: (context) => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                builder: (context, controller, focusNode) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      labelText: 'Search Country',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  );
                },
                decorationBuilder: (context, child) {
                  return Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(12),
                    child: child,
                  );
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    leading: Text(suggestion.isoCode),
                    title: Text(suggestion.countryName),
                  );
                },
                onSelected: (suggestion) {
                  FocusScope.of(context).unfocus();
                  ref
                      .read(emergencyContactsProvider.notifier)
                      .searchContact(suggestion.countryName);
                },
                suggestionsCallback: (pattern) {
                  return state.contacts
                      .where(
                        (contact) => contact.countryName.toLowerCase().contains(
                              pattern.toLowerCase(),
                            ),
                      )
                      .toList();
                },
              ),
            ),
            const SizedBox(height: 20),
            if (state.selectedContact != null)
              Expanded(
                child:
                    _buildContactDetails(context, ref, state.selectedContact!),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactDetails(
      BuildContext context, WidgetRef ref, EmergencyContact contact) {
    if (contact.ambulance.isEmpty &&
        contact.fire.isEmpty &&
        contact.police.isEmpty &&
        contact.dispatch.isEmpty) {
      return Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'No emergency numbers available for ${contact.countryName}.',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  WidgetUtils.showAddNumbersDialog(context, contact, ref);
                },
                child: const Text('Add Emergency Numbers'),
              ),
            ],
          ),
        ),
      );
    }
    return ContactDetails(contact: contact);
  }
}

class WidgetUtils {
  static Widget _buildTextField(
      TextEditingController controller, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: text,
          icon: Icon(icon),
        ),
        keyboardType: TextInputType.phone,
      ),
    );
  }

  static void showAddNumbersDialog(
      BuildContext context, EmergencyContact contact, WidgetRef ref) {
    final ambulanceController = TextEditingController(text: contact.ambulance);
    final fireController = TextEditingController(text: contact.fire);
    final policeController = TextEditingController(text: contact.police);
    final dispatchController = TextEditingController(text: contact.dispatch);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Add Emergency Numbers for ${contact.countryName}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(
                    ambulanceController, 'Ambulance', Icons.local_hospital),
                _buildTextField(fireController, 'Fire', Icons.fire_truck),
                _buildTextField(policeController, 'Police', Icons.local_police),
                _buildTextField(dispatchController, 'Dispatch', Icons.phone),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(emergencyContactsProvider.notifier)
                    .updateContactNumbers(
                      contact,
                      ambulance: ambulanceController.text,
                      fire: fireController.text,
                      police: policeController.text,
                      dispatch: dispatchController.text,
                    );
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            )
          ],
        );
      },
    );
  }
}

class ContactDetails extends ConsumerWidget {
  final EmergencyContact contact;

  const ContactDetails({super.key, required this.contact});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  contact.countryName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () =>
                      WidgetUtils.showAddNumbersDialog(context, contact, ref),
                  icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      size: 18.0,
                    ),
                  ),
                )
              ],
            ),
            subtitle: Text('ISO Code: ${contact.isoCode}'),
          ),
          const Divider(),
          _buildContactTile(context, 'Ambulance', contact.ambulance,
              Icons.local_hospital, ref),
          _buildContactTile(
              context, 'Fire', contact.fire, Icons.local_fire_department, ref),
          _buildContactTile(
              context, 'Police', contact.police, Icons.local_police, ref),
          _buildContactTile(
              context, 'Dispatch', contact.dispatch, Icons.phone, ref),
          _buildNotesTile(context),
        ],
      ),
    );
  }

  Widget _buildNotesTile(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.note,
        color: Colors.white,
        size: 19.0,
      ),
      title: Text(
        'Notes',
        style: TextStyle(
            color: Theme.of(context).hintColor, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        contact.notes ?? 'No notes available',
        style: TextStyle(
            color: Theme.of(context).hintColor,
            fontWeight: FontWeight.w400,
            fontSize: 14.0),
      ),
    );
  }

  Widget _buildContactTile(BuildContext context, String service, String number,
      IconData icon, WidgetRef ref) {
    if (number.isEmpty) {
      return const SizedBox();
    }

    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(service),
      trailing: ElevatedButton.icon(
        icon: const Icon(
          Icons.phone,
        ),
        label: Text(number),
        onPressed: number.isNotEmpty
            ? () => _launchUrl(Uri(scheme: 'tel', path: number), context)
            : null,
      ),
    );
  }

  void _launchUrl(Uri number, BuildContext context) async {
    if (await canLaunchUrl(number)) {
      await launchUrl(number);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch phone call for ${number.data}'),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    }
  }
}

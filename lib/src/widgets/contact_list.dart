import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter/src/viewmodels/contact/contact_view_model.dart';
import 'package:learn_flutter/src/widgets/contact_card.dart';

import '../models/contact.dart';

class ContactList extends StatelessWidget {
  final List<Contact> contacts;

  const ContactList({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final contactCubit = context.read<ContactCubit>();
        contactCubit.fetchContacts();
      },
      child: ListView.builder(
        itemCount: contacts.length,
        padding: const EdgeInsets.only(bottom: 150, top: 20),
        itemBuilder: (context, index) {
          Contact contact = contacts[index];
          return ContactCard(contact: contact);
        },
      ),
    );
  }
}

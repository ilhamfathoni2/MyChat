import 'package:bloc/bloc.dart';
import 'package:learn_flutter/src/models/contact.dart';
import 'package:learn_flutter/src/services/contacts/contact_service.dart';
import 'package:learn_flutter/src/viewmodels/contact/contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  final ContactRepository _repository = ContactRepository();

  ContactCubit() : super(ContactInitial());

  Future<void> fetchContacts() async {
    try {
      emit(ContactLoading());
      final contactsData = await _repository.fetchContacts();

      final List<Contact> contacts = contactsData
          .map((data) => Contact(
                id: data.id,
                name: data.name,
                shortMessage: data.shortMessage,
                time: data.time,
                image: data.image,
              ))
          .toList();

      emit(ContactLoaded(contacts));
    } catch (error) {
      emit(const ContactError('Failed to fetch contacts bloc'));
    }
  }
}

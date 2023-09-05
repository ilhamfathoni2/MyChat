import 'package:bloc/bloc.dart';
import 'package:learn_flutter/src/services/contacts/contact_service.dart';
import 'package:learn_flutter/src/viewmodels/message/message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final ContactRepository _repository = ContactRepository();

  MessageCubit() : super(MessageLoading());

  Future<void> fetchMessageById(String id) async {
    try {
      emit(MessageLoading());
      final messageData = await _repository.fetchMessageById(id);
      if (messageData != null) {
        emit(MessageLoaded(messageData));
      } else {
        emit(const MessageError('Message not found'));
      }
    } catch (error) {
      emit(const MessageError('Failed to fetch message (bloc)'));
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:learn_flutter/src/models/message.dart';

class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final Message message;

  const MessageLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class MessageError extends MessageState {
  final String errorMessage;

  const MessageError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

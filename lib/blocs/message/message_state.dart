import 'package:equatable/equatable.dart';

import '../../models/message.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<Message> messages;

  const MessageLoaded([this.messages = const []]);

  @override
  List<Object> get props => [messages];
}

class MessageNotLoaded extends MessageState {}

class MessageImageLoading extends MessageState {}

class MessageImageFail extends MessageState {}

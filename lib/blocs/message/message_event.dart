import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/message.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class LoadMessage extends MessageEvent {}

class AddNewMessage extends MessageEvent {
  final Message message;

  const AddNewMessage(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'AddNewMessage { message: $message }';
}

class AddNewJoinRoomMessage extends MessageEvent {
  final Message message;

  const AddNewJoinRoomMessage(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'AddNewJoinRoomMessage { message: $message }';
}

class AddNewImageMessage extends MessageEvent {
  final String username;
  final String userId;
  final String userImage;

  const AddNewImageMessage({
    @required this.userImage,
    @required this.username,
    @required this.userId,
  });

  @override
  List<Object> get props => [username, userId, userImage];
}

class MessagesUpdated extends MessageEvent {
  final List<Message> messages;

  const MessagesUpdated(this.messages);

  @override
  List<Object> get props => [messages];
}

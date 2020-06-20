import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message.dart';
import '../../models/message.dart';
import '../../repositories/message_repository.dart';
import '../../repositories/user_repository.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository _messageRepository;
  UserRepository _userRepository;
  StreamSubscription _messagesSubscription;

  MessageBloc(
      {@required MessageRepository messageRepository,
      @required UserRepository userRepository})
      : assert(messageRepository != null),
        _messageRepository = messageRepository,
        _userRepository = userRepository;

  @override
  MessageState get initialState => MessageLoading();

  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is LoadMessage) {
      yield* _mapLoadMessageToState();
    } else if (event is AddNewMessage) {
      yield* _mapAddnewMessageToState(event);
    } else if (event is MessagesUpdated) {
      yield* _mapMessagesUpdateToState(event);
    } else if (event is AddNewJoinRoomMessage) {
      yield* _mapAddNewJoinRoomMessageToState(event);
    } else if (event is AddNewImageMessage) {
      yield* _mapAddNewImageMessageToState(event);
    }
  }

  Stream<MessageState> _mapLoadMessageToState() async* {
    _messagesSubscription?.cancel();
    _messagesSubscription = _messageRepository.loadedMessage().listen(
          (messages) => add(
            MessagesUpdated(messages),
          ),
        );
  }

  Stream<MessageState> _mapAddnewMessageToState(AddNewMessage event) async* {
    _messageRepository.addNewMessage(event.message);
  }

  Stream<MessageState> _mapAddNewJoinRoomMessageToState(
      AddNewJoinRoomMessage event) async* {
    _messageRepository.addNewMessage(event.message);
    _userRepository.setVerifiedStatus(await _userRepository.getUserId());
  }

  Stream<MessageState> _mapMessagesUpdateToState(MessagesUpdated event) async* {
    yield MessageLoaded(event.messages);
  }

  Stream<MessageState> _mapAddNewImageMessageToState(
      AddNewImageMessage event) async* {
    yield MessageLoading();
    try {
      final url = await _userRepository.uploadImage();
      _messageRepository.addNewMessage(Message(
          userId: event.userId,
          userImage: event.userImage,
          username: event.username,
          createdAt: Timestamp.now(),
          text: url,
          type: 'IMAGE_MESSAGE_TYPE'));
    } catch (_) {
      _messagesSubscription?.cancel();
      _messagesSubscription = _messageRepository.loadedMessage().listen(
            (messages) => add(
              MessagesUpdated(messages),
            ),
          );
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}

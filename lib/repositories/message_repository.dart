import 'dart:async';

import '../models/message.dart';

abstract class MessageRepository {
  Future<void> addNewMessage(Message message);

  Stream<List<Message>> loadedMessage();
}

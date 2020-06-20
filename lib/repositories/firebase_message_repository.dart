import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import './message_repository.dart';
import '../models/message.dart';
import '../entities/message_entity.dart';

class FirebaseMessageRepository implements MessageRepository {
  final chats = Firestore.instance.collection('chat');

  @override
  Future<void> addNewMessage(Message message) {
    return chats.add(message.toEntity().toDocument());
  }

  Stream<List<Message>> loadedMessage() {
    return chats.orderBy('createdAt', descending: true).snapshots().map(
      (snapshot) {
        return snapshot.documents
            .map(
              (doc) => Message.fromEntity(
                MessageEntity.fromSnapshot(doc),
              ),
            )
            .toList();
      },
    );
  }
}

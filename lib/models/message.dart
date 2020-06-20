import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../entities/message_entity.dart';

@immutable
class Message {
  final String id;
  final String type;
  final String userId;
  final String username;
  final String userImage;
  final String text;
  final Timestamp createdAt;

  Message({
    String id,
    @required this.type,
    @required this.text,
    @required this.userId,
    @required this.username,
    @required this.userImage,
    @required this.createdAt,
  }) : this.id = id;

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      type: type,
      userId: userId,
      username: username,
      userImage: userImage,
      text: text,
      createdAt: createdAt,
    );
  }

  factory Message.fromEntity(MessageEntity entity) {
    return Message(
      id: entity.id,
      type: entity.type,
      userId: entity.userId,
      username: entity.username,
      userImage: entity.userImage,
      text: entity.text,
      createdAt: entity.createdAt,
    );
  }
}

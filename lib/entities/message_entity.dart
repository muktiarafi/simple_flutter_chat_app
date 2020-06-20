import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageEntity {
  final String id;
  final String type;
  final String userId;
  final String username;
  final String text;
  final String userImage;
  final Timestamp createdAt;

  MessageEntity({
    @required this.id,
    @required this.type,
    @required this.userId,
    @required this.username,
    @required this.text,
    @required this.userImage,
    @required this.createdAt,
  });

  factory MessageEntity.fromSnapshot(DocumentSnapshot snapshot) {
    return MessageEntity(
      id: snapshot.documentID,
      type: snapshot.data['type'],
      userId: snapshot.data['userId'],
      username: snapshot.data['username'],
      text: snapshot.data['text'],
      userImage: snapshot.data['userImage'],
      createdAt: snapshot.data['createdAt'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'text': text,
      'type': type,
      'userId': userId,
      'username': username,
      'userImage': userImage,
      'createdAt': createdAt,
    };
  }
}

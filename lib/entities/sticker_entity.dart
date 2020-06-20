import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StickerEntity {
  final String id;
  final String url;
  final String filetype;

  StickerEntity({
    @required this.id,
    @required this.url,
    @required this.filetype,
  });

  factory StickerEntity.fromSnapshot(DocumentSnapshot snapshot) {
    return StickerEntity(
      id: snapshot.documentID,
      url: snapshot.data['url'],
      filetype: snapshot.data['filetype'],
    );
  }
}

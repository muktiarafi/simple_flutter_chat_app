import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/sticker_entity.dart';

@immutable
class Sticker {
  final String id;
  final String url;
  final String filetype;

  Sticker({
    @required this.id,
    @required this.url,
    @required this.filetype,
  });

  factory Sticker.fromEntity(StickerEntity entity) {
    return Sticker(
      id: entity.id,
      url: entity.url,
      filetype: entity.filetype,
    );
  }
}

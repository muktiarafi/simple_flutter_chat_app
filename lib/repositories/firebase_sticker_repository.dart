import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/sticker_entity.dart';
import '../models/sticker.dart';
import './sticker_repository.dart';

class FirebaseStickerRepository implements StickerRepository {
  final stickers = Firestore.instance.collection('stickers');

  @override
  Stream<List<Sticker>> loadedSticker() {
    return stickers.snapshots().map(
      (snapshot) {
        return snapshot.documents
            .map(
              (doc) => Sticker.fromEntity(
                StickerEntity.fromSnapshot(doc),
              ),
            )
            .toList();
      },
    );
  }
}

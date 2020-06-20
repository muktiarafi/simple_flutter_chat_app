import 'dart:async';

import '../models/sticker.dart';

abstract class StickerRepository {
  Stream<List<Sticker>> loadedSticker() {}
}

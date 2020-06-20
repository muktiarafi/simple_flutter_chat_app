import 'package:equatable/equatable.dart';

import '../../models/sticker.dart';

abstract class StickerEvent extends Equatable {
  const StickerEvent();

  @override
  List<Object> get props => [];
}

class LoadSticker extends StickerEvent {}

class StickersUpdated extends StickerEvent {
  final List<Sticker> stickers;

  const StickersUpdated(this.stickers);

  @override
  List<Object> get props => [stickers];
}

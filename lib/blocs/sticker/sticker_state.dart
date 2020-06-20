import 'package:equatable/equatable.dart';

import '../../models/sticker.dart';

abstract class StickerState extends Equatable {
  const StickerState();

  @override
  List<Object> get props => [];
}

class StickerLoading extends StickerState {}

class StickersLoaded extends StickerState {
  final List<Sticker> stickers;

  const StickersLoaded([this.stickers = const []]);

  @override
  List<Object> get props => [stickers];
}

class StickerNotLoaded extends StickerState {}

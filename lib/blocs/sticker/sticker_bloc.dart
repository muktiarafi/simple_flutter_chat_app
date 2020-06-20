import 'dart:async';

import 'package:bloc/bloc.dart';

import './sticker.dart';
import 'package:meta/meta.dart';

import '../../repositories/sticker_repository.dart';

class StickerBloc extends Bloc<StickerEvent, StickerState> {
  final StickerRepository _stickerRepository;
  StreamSubscription _stickersSubscription;

  StickerBloc({@required StickerRepository stickerRepository})
      : assert(stickerRepository != null),
        _stickerRepository = stickerRepository;

  @override
  StickerState get initialState => StickerLoading();

  Stream<StickerState> mapEventToState(StickerEvent event) async* {
    if (event is LoadSticker) {
      yield* _mapLoadstickerToState();
    } else if (event is StickersUpdated) {
      yield* _mapStickersUpdatedToStream(event);
    }
  }

  Stream<StickerState> _mapLoadstickerToState() async* {
    _stickersSubscription?.cancel();
    _stickersSubscription = _stickerRepository.loadedSticker().listen(
          (stickers) => add(
            StickersUpdated(stickers),
          ),
        );
  }

  Stream<StickerState> _mapStickersUpdatedToStream(
      StickersUpdated event) async* {
    yield StickersLoaded(event.stickers);
  }
}

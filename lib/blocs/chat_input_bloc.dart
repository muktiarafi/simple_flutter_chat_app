import 'package:rxdart/rxdart.dart';

enum ChatInputAction {
  OnShowSticker,
  OnHideSticker,
  OnType,
}

class ChatInputBloc {
  final BehaviorSubject<ChatInputAction> _inputAction = BehaviorSubject();

  BehaviorSubject<ChatInputAction> get inputAction => _inputAction;

  void showStickerPane() {
    _inputAction.sink.add(ChatInputAction.OnShowSticker);
  }

  void hideStickerPane() {
    _inputAction.sink.add(ChatInputAction.OnHideSticker);
  }

  dispose() {
    _inputAction.close();
  }
}

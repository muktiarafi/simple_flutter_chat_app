import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import './edit_profile.dart';
import '../../utils/validators.dart';
import '../../repositories/user_repository.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  UserRepository _userRepository;

  EditProfileBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  EditProfileState get initialState => EditProfileState.empty();

  @override
  Stream<Transition<EditProfileEvent, EditProfileState>> transformEvents(
    Stream<EditProfileEvent> events,
    TransitionFunction<EditProfileEvent, EditProfileState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! OnUsernameFieldChanged);
    });
    final debounceStream = events.where((event) {
      return (event is OnUsernameFieldChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  Stream<EditProfileState> mapEventToState(EditProfileEvent event) async* {
    if (event is OnUsernameFieldChanged) {
      yield* _mapOnUsernameFieldChanged(event.username);
    } else if (event is OnEditUsernameSubmit) {
      yield* _mapOnEditUsernameSubmit(event.username);
    } else if (event is OnProfileImageButtonPressed) {
      yield* _mapOnProfileImageButtonPressed();
    }
  }

  Stream<EditProfileState> _mapOnUsernameFieldChanged(String username) async* {
    yield state.usernameUpdate(Validators.isValidUsername(username));
  }

  Stream<EditProfileState> _mapOnEditUsernameSubmit(String username) async* {
    yield EditProfileState.usernameLoading();
    try {
      final String userId = await _userRepository.getUserId();
      await _userRepository.updateProfile(userId, username);
      yield EditProfileState.usernameSuccess();
    } catch (_) {
      yield EditProfileState.usernameFailure();
    }
  }

  Stream<EditProfileState> _mapOnProfileImageButtonPressed() async* {
    yield EditProfileState.profileImageLoading();
    try {
      final String userId = await _userRepository.getUserId();
      final url = await _userRepository.uploadProfileImage(userId);
      yield EditProfileState.profileImageSuccess(url);
    } catch (_) {
      yield EditProfileState.profileImageFailure();
    }
  }
}

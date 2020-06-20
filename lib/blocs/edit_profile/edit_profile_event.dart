import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class OnUsernameFieldChanged extends EditProfileEvent {
  final String username;

  const OnUsernameFieldChanged({@required this.username});

  @override
  List<Object> get props => [username];
}

class OnEditUsernameSubmit extends EditProfileEvent {
  final String username;

  const OnEditUsernameSubmit({
    @required this.username,
  });

  @override
  List<Object> get props => [username];
}

class OnProfileImageButtonPressed extends EditProfileEvent {}

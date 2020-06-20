import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends RegisterEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class UsernameChanged extends RegisterEvent {
  final String username;

  const UsernameChanged({@required this.username});

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'UsernameChanged { username: $username }';
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;
  final String username;

  const Submitted({
    @required this.email,
    @required this.password,
    @required this.username,
  });

  @override
  List<Object> get props => [email, password, username];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password, username: $username }';
  }
}

part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String userId;
  final String username;
  final String userImage;
  final bool verified;

  const Authenticated(
      {this.userId, this.username, this.verified, this.userImage});

  @override
  List<Object> get props => [
        userId,
        username,
        verified,
        userImage,
      ];

  @override
  String toString() =>
      'Authenticated { userId: $userId, username: $username, verified: $verified }';
}

class Unauthenticated extends AuthenticationState {}

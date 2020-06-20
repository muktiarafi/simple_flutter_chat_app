import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication.dart';
import '../../blocs/edit_profile/edit_profile.dart';
import '../../repositories/user_repository.dart';
import './profile_form.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String userImage;
  final UserRepository _userRepository = UserRepository();

  ProfileScreen({
    this.username,
    this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: BlocProvider(
        create: (context) => EditProfileBloc(userRepository: _userRepository),
        child: WillPopScope(
          onWillPop: () {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
            return Future.value(true);
          },
          child: ProfileForm(userImage, username),
        ),
      ),
    );
  }
}

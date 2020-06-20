import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../blocs/authentication/authentication.dart';
import '../../blocs/edit_profile/edit_profile.dart';

class ProfileForm extends StatefulWidget {
  final String userImage;
  final String username;

  ProfileForm(this.userImage, this.username);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final TextEditingController _usernameController = TextEditingController();

  EditProfileBloc _editProfileBloc;

  @override
  void initState() {
    super.initState();
    _editProfileBloc = BlocProvider.of<EditProfileBloc>(context);
    _usernameController.text = widget.username;
    _usernameController.addListener(_onUsernameChanged);
  }

  bool _isValid(EditProfileState state) {
    return state.isUsernameValid;
  }

  void _onUsernameChanged() {
    _editProfileBloc.add(
      OnUsernameFieldChanged(username: _usernameController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state.isEditProfileImageFailed) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Fail to upload image'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isEditProfileImageSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Profile image updated succesfully'),
                    Icon(Icons.info),
                  ],
                ),
              ),
            );
        }
        if (state.isEditUsernameSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Updating....'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isEditUsernameFailed) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Fail to update username'),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isEditUsernameSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Username updated successfully'),
                    Icon(Icons.info),
                  ],
                ),
              ),
            );
        }
      },
      child: BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.05), BlendMode.dstATop),
                image: AssetImage('assets/images/city.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    state.isEditProfileImageUploading
                        ? CircularProgressIndicator()
                        : Container(
                            margin: EdgeInsets.all(20),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                height: 200,
                                width: 200,
                                imageUrl: state.userImage ?? widget.userImage,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                    FlatButton.icon(
                      onPressed: () {
                        _editProfileBloc.add(OnProfileImageButtonPressed());
                      },
                      icon: Icon(Icons.image),
                      label: Text('Upload Image'),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Text(
                              "USERNAME",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.redAccent,
                              width: 0.5,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Form(
                              child: TextFormField(
                                controller: _usernameController,
                                keyboardType: TextInputType.text,
                                autovalidate: true,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                validator: (_) {
                                  return !state.isUsernameValid
                                      ? 'Username is not valid'
                                      : null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.red,
                        onPressed: _isValid(state)
                            ? () {
                                _editProfileBloc.add(
                                  OnEditUsernameSubmit(
                                      username: _usernameController.text),
                                );
                              }
                            : () {},
                        child: Text(
                          "UPDATE USERNAME",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      alignment: Alignment.bottomCenter,
                      child: FlatButton.icon(
                        onPressed: () {
                          BlocProvider.of<AuthenticationBloc>(context).add(
                            LoggedOut(),
                          );
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.exit_to_app,
                          size: 50,
                          color: Colors.red,
                        ),
                        label: Text(
                          'Logout',
                          style: TextStyle(fontSize: 24, color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

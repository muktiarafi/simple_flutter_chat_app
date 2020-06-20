import 'package:meta/meta.dart';

class EditProfileState {
  final bool isUsernameValid;
  final bool isEditProfileImageUploading;
  final bool isEditProfileImageSuccess;
  final bool isEditProfileImageFailed;
  final bool isEditUsernameSubmitting;
  final bool isEditUsernameSuccess;
  final bool isEditUsernameFailed;
  String userImage =
      'https://firebasestorage.googleapis.com/v0/b/flutter-chat-41725.appspot.com/o/person-logo-png.png?alt=media&token=2ef7f860-21f5-406d-b29e-ba3491e48cf0';

  EditProfileState({
    @required this.isUsernameValid,
    @required this.isEditProfileImageUploading,
    @required this.isEditProfileImageSuccess,
    @required this.isEditProfileImageFailed,
    @required this.isEditUsernameSubmitting,
    @required this.isEditUsernameFailed,
    @required this.isEditUsernameSuccess,
    String userImage,
  }) : this.userImage = userImage;

  factory EditProfileState.empty() {
    return EditProfileState(
      isUsernameValid: false,
      isEditUsernameSubmitting: false,
      isEditProfileImageFailed: false,
      isEditProfileImageSuccess: false,
      isEditProfileImageUploading: false,
      isEditUsernameFailed: false,
      isEditUsernameSuccess: false,
    );
  }

  factory EditProfileState.usernameLoading() {
    return EditProfileState(
      isUsernameValid: true,
      isEditProfileImageUploading: false,
      isEditProfileImageSuccess: false,
      isEditProfileImageFailed: false,
      isEditUsernameSubmitting: true,
      isEditUsernameFailed: false,
      isEditUsernameSuccess: false,
    );
  }

  EditProfileState usernameUpdate(
    bool isUsernameValid,
  ) {
    return EditProfileState(
      isUsernameValid: isUsernameValid,
      isEditProfileImageUploading: false,
      isEditProfileImageSuccess: false,
      isEditProfileImageFailed: false,
      isEditUsernameSubmitting: false,
      isEditUsernameFailed: false,
      isEditUsernameSuccess: false,
    );
  }

  EditProfileState copyWith({
    bool isUsernameValid,
    bool isEditProfileImageUploading,
    bool isEditProfileImageSuccess,
    bool isEditProfileImageFailed,
    bool isEditUsernameSubmitting,
    bool isEditUsernameSuccess,
    bool isEditUsernameFailed,
  }) {
    return EditProfileState(
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isEditProfileImageUploading:
          isEditProfileImageUploading ?? this.isEditProfileImageUploading,
      isEditProfileImageSuccess:
          isEditProfileImageSuccess ?? this.isEditProfileImageSuccess,
      isEditProfileImageFailed:
          isEditProfileImageFailed ?? this.isEditProfileImageFailed,
      isEditUsernameSubmitting:
          isEditUsernameSubmitting ?? this.isEditUsernameSubmitting,
      isEditUsernameFailed:
          isEditUsernameFailed ?? this.isEditProfileImageFailed,
      isEditUsernameSuccess:
          isEditUsernameSuccess ?? this.isEditProfileImageSuccess,
    );
  }

  factory EditProfileState.usernameFailure() {
    return EditProfileState(
      isUsernameValid: true,
      isEditProfileImageUploading: false,
      isEditProfileImageSuccess: false,
      isEditProfileImageFailed: false,
      isEditUsernameSubmitting: false,
      isEditUsernameFailed: true,
      isEditUsernameSuccess: false,
    );
  }

  factory EditProfileState.usernameSuccess() {
    return EditProfileState(
      isUsernameValid: true,
      isEditProfileImageUploading: false,
      isEditProfileImageSuccess: false,
      isEditProfileImageFailed: false,
      isEditUsernameSubmitting: false,
      isEditUsernameFailed: false,
      isEditUsernameSuccess: true,
    );
  }

  factory EditProfileState.profileImageLoading() {
    return EditProfileState(
      isUsernameValid: false,
      isEditProfileImageUploading: true,
      isEditProfileImageSuccess: false,
      isEditProfileImageFailed: false,
      isEditUsernameSubmitting: false,
      isEditUsernameFailed: false,
      isEditUsernameSuccess: false,
    );
  }

  factory EditProfileState.profileImageFailure() {
    return EditProfileState(
      isUsernameValid: false,
      isEditProfileImageUploading: false,
      isEditProfileImageSuccess: false,
      isEditProfileImageFailed: true,
      isEditUsernameSubmitting: false,
      isEditUsernameFailed: false,
      isEditUsernameSuccess: false,
    );
  }

  factory EditProfileState.profileImageSuccess(String imageUrl) {
    return EditProfileState(
      isUsernameValid: false,
      isEditProfileImageUploading: false,
      isEditProfileImageSuccess: true,
      isEditProfileImageFailed: false,
      isEditUsernameSubmitting: false,
      isEditUsernameFailed: false,
      isEditUsernameSuccess: false,
      userImage: imageUrl,
    );
  }

  @override
  String toString() {
    return '''EditProfileState(
      isUsernameValid: $isUsernameValid,
      isEditProfileImageUploading: $isEditProfileImageUploading,
      isEditProfileImageSuccess: $isEditUsernameSuccess,
      isEditProfileImageFailed: $isEditProfileImageFailed,
      isEditUsernameSubmitting: $isEditUsernameSubmitting,
      isEditUsernameFailed: $isEditUsernameFailed,
      isEditUsernameSuccess: $isEditUsernameSuccess,
    )''';
  }
}

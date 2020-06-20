import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithCredentials({
    @required String email,
    @required String password,
  }) async {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({
    @required String email,
    @required String password,
    @required String username,
  }) async {
    return authenticate(email: email, password: password, username: username);
  }

  Future<void> authenticate({
    @required String email,
    @required String password,
    @required String username,
  }) async {
    try {
      final auth = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await Firestore.instance
          .collection('users')
          .document(auth.user.uid)
          .setData({
        'username': username,
        'email': email,
        'verified': false,
        'image_url':
            'https://firebasestorage.googleapis.com/v0/b/flutter-chat-41725.appspot.com/o/person-logo-png.png?alt=media&token=2ef7f860-21f5-406d-b29e-ba3491e48cf0',
      });
    } catch (_) {
      throw Error;
    }
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUserId() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<DocumentSnapshot> getUserDocument(String userId) async {
    return await Firestore.instance.collection('users').document(userId).get();
  }

  Future<void> setVerifiedStatus(String userId) async {
    await Firestore.instance.collection('users').document(userId).setData({
      'verified': true,
    }, merge: true);
  }

  Future<File> pickProfileImage() async {
    final pickedImage = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 70);
    final File image = File(pickedImage.path);
    if (image == null) {
      throw Error;
    }
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.redAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    return croppedFile;
  }

  Future<String> uploadProfileImage(String userId) async {
    final StorageReference ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child('$userId-user_image');
    StorageUploadTask uploadTask = ref.putFile(await pickProfileImage());
    await uploadTask.onComplete;
    final String url = await ref.getDownloadURL();
    await Firestore.instance.collection('users').document(userId).setData({
      'image_url': url,
    }, merge: true);
    return url;
  }

  Future<void> updateProfile(
    String userId,
    String username,
  ) async {
    await Firestore.instance.collection('users').document(userId).setData({
      'username': username,
    }, merge: true);
  }

  Future<String> uploadImage() async {
    final pickedImage = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 70);
    final File image = File(pickedImage.path);
    final StorageReference ref = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${DateTime.now()}');
    StorageUploadTask uploadTask = ref.putFile(image);
    await uploadTask.onComplete;
    final String url = await ref.getDownloadURL();
    return url;
  }
}

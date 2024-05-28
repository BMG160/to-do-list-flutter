
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:to_do_list/constant/strings.dart';
import 'package:to_do_list/network/data_agent/firebase_storage_store.dart';

class FirebaseStorageStoreImpl extends FirebaseStorageStore{
  FirebaseStorageStoreImpl._();

  static final FirebaseStorageStoreImpl _singleton = FirebaseStorageStoreImpl._();

  factory FirebaseStorageStoreImpl() => _singleton;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<void> deleteUserProfile(String profileID) => _storage
      .ref(kRootNodeForUserProfileUploadPath)
      .child(profileID)
      .delete();

  @override
  Future<String> uploadUserProfileToFireStorage(String profileID, File userProfile) => _storage
      .ref(kRootNodeForUserProfileUploadPath)
      .child(profileID)
      .putFile(userProfile)
      .then((takeSnapShot) => takeSnapShot.ref.getDownloadURL());
  
  
}
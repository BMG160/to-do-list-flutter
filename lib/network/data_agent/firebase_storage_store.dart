
import 'dart:io';

abstract class FirebaseStorageStore{
  Future<String> uploadUserProfileToFireStorage (String profileID, File userProfile);

  Future<void> deleteUserProfile(String profileID);
}
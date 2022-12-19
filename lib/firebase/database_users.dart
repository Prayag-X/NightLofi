import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:night_lofi/providers/user_provider.dart';

class DatabaseUsers {
  final firebaseDb = FirebaseFirestore.instance;
  final collectionUsers = FirebaseFirestore.instance.collection('Users');

  Future<void> registerUser(String uid, String email, String userName) async {
    await collectionUsers.doc(uid).set({'user_name': userName, 'email': email});
  }

  Future<String> getUserName(String uid) async => await collectionUsers
      .doc(uid)
      .get()
      .then((DocumentSnapshot doc) => doc['user_name']);
}

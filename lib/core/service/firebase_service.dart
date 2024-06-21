import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserCredential? credential;
  static bool loggedIn = false;

  Future<void> register(String email, String password, String fullName) async {
    credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await firestore
        .collection("users")
        .doc(credential?.user!.uid)
        .set({"email": email, "full name": fullName});
    loggedIn = true;
    notifyListeners();
  }

  //auth
  Future<void> signIn(String email, String password) async {
    credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    loggedIn = true;
    notifyListeners();
  }

  Future<void> signOut() async {
    if (loggedIn) {
      await auth.signOut();
    }
  }

  User getUser() {
    return credential!.user!;
  }

  //firestore
  Future<DocumentSnapshot<Object?>> getSnapshot(uid) async {
    DocumentSnapshot documentSnapshot =
        await firestore.collection("users").doc(uid).get();
    return documentSnapshot;
  }

  Future<void> updateUserInformation(
      User user, String fieldName, List newValue) async {
    try {
      DocumentReference documentReference =
          firestore.collection("users").doc(user.uid);
      await documentReference.update({fieldName: newValue});
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}

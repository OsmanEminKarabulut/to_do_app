import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService extends ChangeNotifier {
  //Instances of FirebaseAuth and FirebaseFirestore
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Current users credential and loggedIn statement.
  UserCredential? credential;
  static bool loggedIn = false;

  //Register function
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

  //Sign in function
  Future<void> signIn(String email, String password) async {
    credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    loggedIn = true;
    notifyListeners();
  }

  //Sign out function
  Future<void> signOut() async {
    if (loggedIn) {
      await auth.signOut();
    }
  }

  //This function returns current user
  User getUser() {
    return credential!.user!;
  }

  //This function returns the document with given id.
  Future<DocumentSnapshot<Object?>> getSnapshot(uid) async {
    DocumentSnapshot documentSnapshot =
        await firestore.collection("users").doc(uid).get();
    return documentSnapshot;
  }

  //This function updates de information that given.
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

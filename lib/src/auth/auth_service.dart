import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_profile.dart';

class AuthService {
  static const String collectionName = 'users';
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _googleSignInInitialized = false;

  // Future<User> listenForAuthStateChanges() async {
  //   return FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       if (kDebugMode) {
  //         print('User is currently signed out');
  //       }
  //     } else {
  //       return user;
  //     }
  //   });
  // }

  Future<User?> getCurrentUser() async {
    // if (FirebaseAuth.instance.currentUser != null) {
    //   return FirebaseAuth.instance.currentUser;
    // }
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> setPersistence() async {
    await FirebaseAuth.instance.setPersistence(Persistence.NONE);
  }

  Future<User> signIn() async {
    // Google Sign in
    UserCredential result = await signInWithGoogle();

    // Asserts
    assert(result.user != null);
    User? user = result.user;
    assert(user!.email != null);
    assert(user!.displayName != null);
    assert(user!.photoURL != null);
    assert(!user!.isAnonymous);
    assert(await user!.getIdToken() != null);
    final User currentUser = FirebaseAuth.instance.currentUser!;
    assert(user!.uid == currentUser.uid);
    updateUserData(currentUser);

    if (kDebugMode) {
      print("signed in ${currentUser.displayName}");
    }
    return currentUser;
  }

  Future<UserCredential> signInWithGoogle() async {
    await _ensureGoogleSignInInitialized();
    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    if (googleAuth.idToken == null) {
      throw FirebaseAuthException(
        code: 'missing-id-token',
        message: 'Google Sign-In did not return an ID token.',
      );
    }

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> _ensureGoogleSignInInitialized() async {
    if (_googleSignInInitialized) {
      return;
    }

    await _googleSignIn.initialize();
    _googleSignInInitialized = true;
  }

  Future<UserProfile> getUserProfile(User user) async {
    var documentData = FirebaseFirestore.instance
        .collection(collectionName)
        .doc(user.uid)
        .snapshots()
        .map((snap) {
      return snap.data() as Map<String, dynamic>;
    }) as Map<String, dynamic>;
    UserProfile userProfile = UserProfile.fromJson(documentData);
    return userProfile;
  }

  Future<void> updateUserData(User user) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection(collectionName).doc(user.uid);
    ref.set({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoURL,
      'displayName': user.displayName,
      'lastSeen': DateTime.now(),
      'firstName': parseFirstName(user.displayName),
      'lastName': parseLastName(user.displayName)
    });
  }

  String parseFirstName(String? displayName) {
    return displayName!.contains(" ")
        ? displayName.substring(0, displayName.indexOf(" "))
        : displayName;
  }

  String parseLastName(String? displayName) {
    return displayName!.contains(" ")
        ? displayName.substring(displayName.indexOf(" "), displayName.length)
        : displayName;
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'auth_service.dart';

import 'user_profile.dart';

class AuthController with ChangeNotifier {
  AuthController(this._authService);

  final AuthService _authService;

  late User _currentUser;
  User get user => _currentUser;

  late UserProfile _userProfile;
  UserProfile get userProfile => _userProfile;

  PublishSubject loading = PublishSubject();

  Future<User?> getCurrentUser() async {
    loading.add(true);
    return _authService.getCurrentUser();
  }

  Future<void> signOut() async {
    _authService.signOut();
  }

  Future<void> signIn() async {
    loading.add(true);
    _currentUser = await _authService.signIn();
    _userProfile = await _authService.getUserProfile(_currentUser);

    loading.add(false);
    if (kDebugMode) {
      print("signed in ${_currentUser.displayName}");
    }

    notifyListeners();
  }
}

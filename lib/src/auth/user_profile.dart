class UserProfile {
  UserProfile(
      {required this.uid,
      required this.displayName,
      required this.email,
      required this.photoURL,
      required this.isAnonymous});

  String uid;
  String displayName;
  String email;
  String photoURL;
  bool isAnonymous;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'uid': String uid,
        'displayName': String displayName,
        'email': String email,
        'photoURL': String photoURL,
        'isAnonymous': bool isAnonymous,
      } =>
        UserProfile(
            uid: uid,
            displayName: displayName,
            email: email,
            photoURL: photoURL,
            isAnonymous: isAnonymous),
      _ => throw const FormatException('Failed to load RandomDog')
    };
  }
}

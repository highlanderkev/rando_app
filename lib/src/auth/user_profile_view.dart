import 'package:flutter/material.dart';

import 'auth_controller.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key, required this.controller});

  static const routeName = '/user-profile';

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          padding: const EdgeInsets.all(20),
          child: Text(controller.userProfile.toString())),
      Text(controller.loading.toString())
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_view.dart';

class LoginButtonView extends StatelessWidget {
  const LoginButtonView({super.key});

  // final AuthController controller;

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //       future: controller.getCurrentUser(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           User user = snapshot.data!;
  //           return ElevatedButton.icon(
  //               onPressed: () => controller.signOut(),
  //               icon: CircleAvatar(
  //                 backgroundImage: NetworkImage(user.photoURL!),
  //               ),
  //               label: Text('${user.displayName}'));
  //         } else {
  //           return IconButton(
  //               icon: const Icon(Icons.account_circle),
  //               tooltip: 'Signin',
  //               onPressed: () {
  //                 Navigator.pushNamed(context, LoginView.routeName);
  //               }
  //               // onPressed: () => controller.signIn(),
  //               );
  //         }
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.account_circle),
        tooltip: 'Signin',
        onPressed: () {
          Navigator.pushNamed(context, LoginView.routeName);
        }
        // onPressed: () => controller.signIn(),
        );
  }
}

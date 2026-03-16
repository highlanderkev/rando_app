import 'package:flutter/material.dart';
import 'package:rando_app/src/localization/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rando_app/src/auth/login_view.dart';
import 'package:rando_app/src/random_cat/random_cat_details_view.dart';
import 'package:rando_app/src/random_dog/random_dog_details_view.dart';
import 'package:rando_app/src/random_number/random_numer_details_view.dart';

import 'auth/auth_controller.dart';
import 'random_selection/random_item_details_view.dart';
import 'random_selection/random_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.settingsController,
      required this.authController});

  final SettingsController settingsController;
  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case LoginView.routeName:
                    return LoginView(controller: authController);
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  // case VideoPlayerView.routeName:
                  //   return const VideoPlayerView();
                  case RandomItemDetailsView.routeName:
                    return const RandomItemDetailsView();
                  case RandomDogDetailsView.routeName:
                    return const RandomDogDetailsView();
                  case RandomNumberDetailsView.routeName:
                    return const RandomNumberDetailsView();
                  case RandomCatDetailsView.routeName:
                    return const RandomCatDetailsView();
                  case RandomItemListView.routeName:
                  default:
                    return const RandomItemListView();
                }
              },
            );
          },
        );
      },
    );
  }
}

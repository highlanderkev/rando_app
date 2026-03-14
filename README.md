# rando_app

A Flutter application that delivers random content — random numbers, random dog images/videos, and random cat images — with Firebase-powered authentication and hosting.

## Features

- 🔢 **Random Number** — generate a random number on demand
- 🐶 **Random Dog** — fetch a random dog image or video
- 🐱 **Random Cat** — fetch a random cat image
- 🔐 **Authentication** — Google Sign-In via Firebase Auth
- 🌐 **Cross-platform** — runs on Android, iOS, and the web

## Tech Stack

| Layer | Technology |
|-------|-----------|
| UI Framework | [Flutter](https://flutter.dev/) / [Dart](https://dart.dev/) |
| Backend / Auth | [Firebase](https://firebase.google.com/) (Core, Auth, Firestore, Analytics, Remote Config) |
| Sign-In | [Google Sign-In](https://pub.dev/packages/google_sign_in) |
| Networking | [http](https://pub.dev/packages/http) |
| Reactive state | [RxDart](https://pub.dev/packages/rxdart) |
| Video playback | [video_player](https://pub.dev/packages/video_player) |
| Config | [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) |
| Localization | Flutter Localizations (ARB files) |
| CI / Hosting | GitHub Actions + Firebase Hosting |

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (Dart SDK `>=3.1.2 <4.0.0`)
- A Firebase project with Authentication (Google provider), Firestore, Analytics, and Hosting enabled
- A `.env` file in the project root (see `.env.example` if provided) containing any required API keys

### Setup

```bash
# Install dependencies
flutter pub get

# Generate JSON serialization code
dart run build_runner build --delete-conflicting-outputs

# Run the app (choose a target device)
flutter run
```

### Running Tests

```bash
flutter test
```

## Project Structure

```
lib/
├── main.dart                  # App entry point
├── firebase_options.dart      # Firebase configuration
└── src/
    ├── app.dart               # Root widget & routing
    ├── auth/                  # Authentication (Google Sign-In)
    ├── settings/              # Theme & user preferences
    ├── random_number/         # Random number feature
    ├── random_dog/            # Random dog image/video feature
    ├── random_cat/            # Random cat image feature
    ├── random_selection/      # Home list & shared selection model
    ├── video_player/          # Video player component
    └── localization/          # ARB localization files
```

## Localization

Localized strings live in `lib/src/localization/`. To add a new language, create an ARB file for that locale and refer to the [Flutter internationalization guide](https://flutter.dev/docs/development/accessibility-and-localization/internationalization).

## Deployment

Pull requests and merges to `main` are automatically deployed to Firebase Hosting via GitHub Actions.

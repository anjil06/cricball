# Cricball - Cricket Score Tracking App

A Flutter application for tracking cricket matches, scorecards, and match history with Firebase backend.

## Features

- **Splash Screen**: App introduction with animated logo
- **Authentication**: User registration and login with Firebase
- **Home Screen**: Dashboard with match creation and quick actions
- **Profile Screen**: User details with logout option
- **Match Creation**: Create matches with:
  - Different match modes (10 overs, 20 overs, 50 overs, custom)
  - Team names
  - Playing 11 players for each team
- **Scorecard Page**: Track and update match scores
- **Match History**: View all previous matches
- **Navigation**: Drawer-based navigation with slider

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
├── models/
│   ├── user.dart            # User model
│   ├── match.dart           # Match model
│   └── scorecard.dart       # Scorecard model
├── services/
│   ├── auth_service.dart    # Firebase authentication
│   └── firestore_service.dart # Firestore operations
├── providers/
│   └── auth_provider.dart   # Authentication state management
├── screens/
│   ├── splash_screen.dart   # Splash screen
│   ├── login_screen.dart    # Login screen
│   ├── signup_screen.dart   # Registration screen
│   ├── home_screen.dart     # Home/dashboard screen
│   ├── profile_screen.dart  # User profile
│   ├── scorecard_screen.dart # Scorecard view
│   ├── history_screen.dart  # Match history
│   └── create_match_screen.dart # Create new match
├── widgets/
│   └── app_logo.dart        # Reusable logo widget
```

## Setup Instructions

### Prerequisites
- Flutter SDK installed
- Firebase project created
- Android/iOS development environment set up

### Firebase Configuration

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Add Android and iOS apps to your Firebase project
3. Download google-services.json (for Android) and GoogleService-Info.plist (for iOS)
4. Place the files in the appropriate directories:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`

### Update Firebase Options

Edit `lib/firebase_options.dart` and replace the placeholder credentials with your actual Firebase project credentials:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: "YOUR_API_KEY",
  authDomain: "YOUR_PROJECT.firebaseapp.com",
  projectId: "YOUR_PROJECT_ID",
  storageBucket: "YOUR_PROJECT.appspot.com",
  messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
  appId: "YOUR_APP_ID",
);
```

### Installation

1. Clone the repository
2. Navigate to the project directory
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

## Firebase Database Structure

### Collections

#### users
```
{
  username: string,
  email: string,
  fullName: string,
  phoneNumber: string,
  profileImageUrl: string (optional),
  createdAt: timestamp
}
```

#### matches
```
{
  team1Name: string,
  team2Name: string,
  mode: string,
  team1Playing11: array,
  team2Playing11: array,
  createdBy: string (userId),
  createdAt: timestamp,
  completedAt: timestamp (optional),
  status: string (ongoing/completed/cancelled),
  winnerTeam: string (optional)
}
```

#### scorecards
```
{
  matchId: string,
  team1Name: string,
  team2Name: string,
  team1Runs: number,
  team1Wickets: number,
  team1Overs: number,
  team2Runs: number,
  team2Wickets: number,
  team2Overs: number,
  team1Innings: array,
  team2Innings: array,
  createdAt: timestamp,
  updatedAt: timestamp
}
```

## Key Features Implementation

### Authentication
- Email/Password authentication with Firebase Auth
- User registration and login
- Automatic redirect based on auth state
- Logout functionality

### State Management
- Provider package for state management
- AuthProvider for managing authentication state
- Persistent user data

### UI Components
- Material Design 3
- Responsive layouts
- Custom widgets for logo and headers
- Navigation drawer
- Page-based navigation

## App Flow

1. **Splash Screen** (3 seconds) → Checks auth state
2. **Login/Signup** → User authentication
3. **Home Screen** → Dashboard with navigation
   - Home Page: Create matches
   - Scorecard Page: Track scores
   - History Page: View past matches
4. **Profile Screen** → User details and logout

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

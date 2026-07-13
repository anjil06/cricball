import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user.dart' as models;
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  models.User? _user;
  bool _isLoading = false;
  String? _error;

  models.User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  Future<bool> signup({
    required String email,
    required String password,
    required String username,
    required String fullName,
    required String phoneNumber,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      models.User? user = await _authService.signUp(
        email: email,
        password: password,
        username: username,
        fullName: fullName,
        phoneNumber: phoneNumber,
      );

      if (user != null) {
        await _firestoreService.createUser(user);
        _user = user;
        _isLoading = false;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      models.User? user = await _authService.login(
        email: email,
        password: password,
      );

      if (user != null) {
        models.User? existingUser = await _firestoreService.getUser(user.uid);
        _user = existingUser ?? user;
        _isLoading = false;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      _user = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateUserProfile(models.User updatedUser) async {
    try {
      await _firestoreService.updateUser(updatedUser);
      _user = updatedUser;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Inside your auth_provider.dart
  Future<void> loadUserData(String uid) async {
    try {
      // Example: Fetching from Firestore
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (doc.exists) {
        // 2. CRITICAL: Assign the fetched data to your provider's variable
        _user = UserModel.fromMap(doc.data()!); // Adjust this to match your actual model

        // 3. CRITICAL: Tell the UI to rebuild!
        notifyListeners();

        print("Data loaded successfully!"); // Add this to check your terminal
      } else {
        print("No user document found in database!");
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}

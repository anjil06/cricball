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

  void clearError() {
    _error = null;
    notifyListeners();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart' as models;

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<models.User?> signUp({
    required String email,
    required String password,
    required String username,
    required String fullName,
    required String phoneNumber,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      models.User user = models.User(
        uid: userCredential.user!.uid,
        username: username,
        email: email,
        fullName: fullName,
        phoneNumber: phoneNumber,
        createdAt: DateTime.now(),
      );

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception('Sign up failed: ${e.message}');
    }
  }

  Future<models.User?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return models.User(
          uid: firebaseUser.uid,
          username: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
          fullName: firebaseUser.displayName ?? '',
          phoneNumber: firebaseUser.phoneNumber ?? '',
          createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
        );
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw Exception('Login failed: ${e.message}');
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception('Logout failed: ${e.message}');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception('Reset password failed: ${e.message}');
    }
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }
}

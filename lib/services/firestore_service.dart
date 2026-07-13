import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart' as models;
import '../models/match.dart';
import '../models/scorecard.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User operations
  Future<void> createUser(models.User user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<models.User?> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return models.User.fromMap(doc.data() as Map<String, dynamic>, uid);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  Future<void> updateUser(models.User user) async {
    try {
      await _firestore.collection('users').doc(user.uid).update(user.toMap());
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  // Match operations
  Future<String> createMatch(Match match) async {
    try {
      DocumentReference docRef = await _firestore.collection('matches').add(match.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create match: $e');
    }
  }

  Future<Match?> getMatch(String matchId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('matches').doc(matchId).get();
      if (doc.exists) {
        return Match.fromMap(doc.data() as Map<String, dynamic>, matchId);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get match: $e');
    }
  }

  Future<List<Match>> getUserMatches(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('matches')
          .where('createdBy', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) => Match.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    } catch (e) {
      throw Exception('Failed to get user matches: $e');
    }
  }

  Future<void> updateMatch(Match match) async {
    try {
      await _firestore.collection('matches').doc(match.id).update(match.toMap());
    } catch (e) {
      throw Exception('Failed to update match: $e');
    }
  }

  Future<void> deleteMatch(String matchId) async {
    try {
      await _firestore.collection('matches').doc(matchId).delete();
    } catch (e) {
      throw Exception('Failed to delete match: $e');
    }
  }

  // Scorecard operations
  Future<String> createScorecard(Scorecard scorecard) async {
    try {
      DocumentReference docRef = await _firestore.collection('scorecards').add(scorecard.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create scorecard: $e');
    }
  }

  Future<Scorecard?> getScorecard(String scorecardId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('scorecards').doc(scorecardId).get();
      if (doc.exists) {
        return Scorecard.fromMap(doc.data() as Map<String, dynamic>, scorecardId);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get scorecard: $e');
    }
  }

  Future<List<Scorecard>> getMatchScorecards(String matchId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('scorecards')
          .where('matchId', isEqualTo: matchId)
          .get();

      return querySnapshot.docs.map((doc) => Scorecard.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    } catch (e) {
      throw Exception('Failed to get match scorecards: $e');
    }
  }

  Future<void> updateScorecard(Scorecard scorecard) async {
    try {
      await _firestore.collection('scorecards').doc(scorecard.id).update(scorecard.toMap());
    } catch (e) {
      throw Exception('Failed to update scorecard: $e');
    }
  }
}

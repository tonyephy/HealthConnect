import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add data
  Future<void> addUserData(String userId, Map<String, dynamic> data) async {
    await _db.collection('users').doc(userId).set(data);
  }

  // Get data
  Future<DocumentSnapshot> getUserData(String userId) async {
    return await _db.collection('users').doc(userId).get();
  }

  // Update data
  Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    await _db.collection('users').doc(userId).update(data);
  }

  // Delete data
  Future<void> deleteUserData(String userId) async {
    await _db.collection('users').doc(userId).delete();
  }
}

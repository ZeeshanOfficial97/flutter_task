import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot>? get stream => _firestore
      .collection('notes')
      .orderBy('timestamp', descending: true)
      .snapshots();

  Future<void> addNote(String content) async {
    if (content.trim().isEmpty) return;
    await _firestore.collection('notes').add({
      'content': content.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteNote(String id) async {
    await _firestore.collection('notes').doc(id).delete();
  }

}
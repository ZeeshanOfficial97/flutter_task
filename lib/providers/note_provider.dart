import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot>? _notesStream;

  Stream<QuerySnapshot>? get notesStream => _notesStream;

  NotesProvider() {
    _init();
  }

  Future<void> _init() async {
    _notesStream = _firestore
        .collection('notes')
        .orderBy('timestamp', descending: true)
        .snapshots();
    notifyListeners();
  }

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

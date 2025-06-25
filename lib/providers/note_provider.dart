import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/repositories/firestore_repository.dart';

class NotesProvider extends ChangeNotifier {
  final FireStoreRepository repository;

  Stream<QuerySnapshot>? _notesStream;

  Stream<QuerySnapshot>? get notesStream => _notesStream;

  NotesProvider(this.repository) {
    _init();
  }

  Future<void> _init() async {
    _notesStream = repository.stream;
    notifyListeners();
  }

  Future<void> addNote(String content) async {
    if (content.trim().isEmpty) return;
    await repository.addNote(content);
  }

  Future<void> deleteNote(String id) async {
    await repository.deleteNote(id);
  }
}

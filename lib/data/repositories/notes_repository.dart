import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/note_model.dart';

class NotesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId;

  NotesRepository(this.userId);

  Future<void> addNote(NoteModel note) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('notes')
        .add(note.toMap());
  }

  Stream<List<NoteModel>> fetchNotes() {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('notes')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => NoteModel.fromMap(doc.data(), doc.id))
              .toList();
        });
  }

  Future<void> updateNote(String noteId, String title, String content) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('notes')
        .doc(noteId)
        .update({
          'title': title,
          'content': content,
          'timestamp': DateTime.now().toIso8601String(),
        });
  }

  Future<void> deleteNote(String noteId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('notes')
        .doc(noteId)
        .delete();
  }
}

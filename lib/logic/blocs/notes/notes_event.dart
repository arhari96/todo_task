import 'package:todo_task/data/models/note_model.dart';

abstract class NotesEvent {}

class LoadNotes extends NotesEvent {}

class AddNote extends NotesEvent {
  final NoteModel note;
  AddNote({required this.note});
}

class UpdateNote extends NotesEvent {
  final String id;
  final String title;
  final String content;
  UpdateNote({required this.id, required this.title, required this.content});
}

class DeleteNote extends NotesEvent {
  final String id;
  DeleteNote({required this.id});
}

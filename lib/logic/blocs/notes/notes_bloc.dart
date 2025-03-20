import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/notes_repository.dart';
import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository notesRepository;

  NotesBloc({required this.notesRepository}) : super(NotesInitial()) {
    on<LoadNotes>((event, emit) async {
      emit(NotesLoading());
      try {
        await emit.forEach(
          notesRepository.fetchNotes(),
          onData: (notes) => NotesLoaded(notes),
          onError: (error, stackTrace) => NotesError(error.toString()),
        );
      } catch (e) {
        emit(NotesError(e.toString()));
      }
    });

    on<AddNote>((event, emit) async {
      await notesRepository.addNote(event.note);
      add(LoadNotes());
    });

    on<UpdateNote>((event, emit) async {
      await notesRepository.updateNote(event.id, event.title, event.content);
      add(LoadNotes());
    });

    on<DeleteNote>((event, emit) async {
      await notesRepository.deleteNote(event.id);
      add(LoadNotes());
    });
  }
}

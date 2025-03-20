import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/logic/blocs/notes/notes_bloc.dart';
import 'package:todo_task/logic/blocs/notes/notes_state.dart';
import 'package:todo_task/presentation/screens/home/create_note_screen.dart';
import 'package:todo_task/presentation/screens/home/note_detail_screen.dart';

import '../../../logic/blocs/notes/notes_event.dart';
import '../../../logic/blocs/profile/profile_bloc.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userId;

  const HomeScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider.value(
                        value: context.read<ProfileBloc>(),
                        child: ProfileScreen(),
                      ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NotesLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return ListTile(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NotesDetailsScreen(noteModel: note),
                        ),
                      ),
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<NotesBloc>().add(DeleteNote(id: note.id));
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            );
          } else if (state is NotesError) {
            return Center(child: Text(state.error));
          } else {
            return Center(child: Text("No notes available"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider.value(
                    value: context.read<NotesBloc>(),
                    child: CreateNoteScreen(userId: userId),
                  ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

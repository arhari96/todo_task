import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/note_model.dart';
import '../../../logic/blocs/notes/notes_bloc.dart';
import '../../../logic/blocs/notes/notes_event.dart';

class CreateNoteScreen extends StatefulWidget {
  final String userId;
  const CreateNoteScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void saveNote() {
    final note = NoteModel(
      id: '',
      title: titleController.text,
      content: contentController.text,
      timestamp: DateTime.now(),
      userId: widget.userId,
    );

    context.read<NotesBloc>().add(AddNote(note: note));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Note")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: "Content"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveNote, child: Text("Save")),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/data/models/note_model.dart';

class NotesDetailsScreen extends StatelessWidget {
  final NoteModel noteModel;
  const NotesDetailsScreen({Key? key, required this.noteModel})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Note Details')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2.h,
        children: <Widget>[
          Text('Id: ${noteModel.id}'),
          Text('Title: ${noteModel.title}'),
          Text('Content: ${noteModel.content}'),
          Text('Date: ${noteModel.timestamp}'),
          Text('User Id: ${noteModel.userId}'),
        ],
      ),
    );
  }
}

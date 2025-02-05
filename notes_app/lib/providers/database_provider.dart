import 'package:flutter/material.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/services/note_database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseProvider extends ChangeNotifier {

  final notesDatabase = NoteDatabase(); 
  final noteController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  void dispose() {
    noteController;
    super.dispose();
  }

  //user wants to add a new note
  void addNewNote(BuildContext context)async{
    final user = _supabase.auth.currentUser;
    if (user == null) return;
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text('Add a new note'),
      content: TextField(
        controller: noteController,
      ),
      actions: [
        TextButton(
          onPressed: (){
            notesDatabase.create(Note(content: noteController.text, userId: user.id));
            noteController.clear();
            Navigator.pop(context);
            notifyListeners();
          },
          child: const Text('Add'),
        ),
        TextButton(
          onPressed: (){
            noteController.clear();
            Navigator.pop(context);
           
          },
          child: const Text('Cancel'),
        ),
      ],
    ));
  }

  //user wants to update an existing note
  void updateNote (BuildContext context, Note note) async{
    //pre fill the text field with the note content
    noteController.text = note.content;
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text('Update note'),
      content: TextField(
        controller: noteController,
      ),
      actions: [
        TextButton(
          onPressed: (){
            notesDatabase.updateNote(note, noteController.text);
            Navigator.pop(context);
            noteController.clear();
            notifyListeners();
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: (){
            Navigator.pop(context);
            noteController.clear();
          },
          child: const Text('Cancel'),
        ),
      ],
    ));
  }

  //user wants to delete an existing note
  void deleteNote(BuildContext context, Note note)async{
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text('Delete note'),
      content: Text('Are you sure you want to delete this note?'),
      actions: [
        TextButton(
          onPressed: (){
            notesDatabase.deleteNote(note);
            Navigator.pop(context);
            notifyListeners();
          },
          child: const Text('Delete'),
        ),
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    ));
  }
}
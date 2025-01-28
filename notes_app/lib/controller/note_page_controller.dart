import 'package:flutter/material.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/services/note_database.dart';
import 'package:notes_app/view/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
 
class NotePageController {
  final notesDatabase = NoteDatabase(); 
  final noteController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;
  //user wants to add a new note
  void addNewNote(BuildContext context){
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
        Navigator.pop(context);
        noteController.clear();
      },
      child: const Text('Add'),
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
  //user wants to update an existing note
  void updateNote (BuildContext context,Note note) async{
    //pre fill the text field with the note content
    noteController.text = note.content;
    showDialog(context: context, builder: (context)=>AlertDialog(
  title: const Text('update note'),
  content: TextField(
    controller: noteController,
  ),
  actions: [
    TextButton(
      onPressed: (){
       notesDatabase.updateNote(note, noteController.text);
        Navigator.pop(context);
        noteController.clear();
      },
      child: const Text('save'),
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
  void deleteNote(BuildContext context,Note note){
    showDialog(context: context, builder: (context)=>AlertDialog(
  title: const Text('Delete note'),
  content: Text('Are you sure you want to delete this note?'),
  actions: [
    TextButton(
      onPressed: (){
        notesDatabase.deleteNote(note);
        Navigator.pop(context);
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

  //logout function
  Future<void> logout(BuildContext context) async {
    try{
      await _supabase.auth.signOut();
      final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
    
    }catch(e){
      print('Unexpected error: $e');
    }
  }

}
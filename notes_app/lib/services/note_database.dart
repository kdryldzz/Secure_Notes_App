import 'package:notes_app/model/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class NoteDatabase {

//database -> notes 
final database = Supabase.instance.client.from('notes');

//create a new note
Future<void> create(Note newnote) async{
  await database.insert(newnote.toMap());
}
  // Read notes for a specific user
  Stream<List<Note>> getNotesForUser(String userId) {
    return database
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map((data) => data.map((noteMap) => Note.fromMap(noteMap)).toList());
  }
//update a note
Future updateNote(Note oldNote,String newContent) async{
  await database.update({'content':newContent}).eq('id',oldNote.id!);
}

//delete a note
Future deleteNote(Note note) async{
  await database.delete().eq('id', note.id!);
}}
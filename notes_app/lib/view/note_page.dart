import 'package:flutter/material.dart';
import 'package:notes_app/controller/note_page_controller.dart';
import 'package:notes_app/services/note_database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final notesDatabase = NoteDatabase();
  final NotePageController _controller = NotePageController();
  final SupabaseClient _supabase = Supabase.instance.client;

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    final user = _supabase.auth.currentUser;
    if (user == null) return const Center(child: Text('User not logged in'));

    return Scaffold(
      //appBar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'My Notes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black45,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _controller.logout(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: StreamBuilder(
            stream: notesDatabase.getNotesForUser(user.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final notes = snapshot.data!;
          
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Card(
                    color: Colors.white.withOpacity(0.8),
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        note.content,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _controller.deleteNote(context, note);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _controller.updateNote(context, note);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.addNewNote(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
class Note {
  int? id;
  String content;
  String userId;

  Note({
    required this.userId,
    this.id,
    required this.content,
  });



  //mapp -> note
 factory Note.fromMap(Map<String,dynamic> map){
  return Note(id: map['id'],
  content:map['content'] as String,
  userId: map['user_id'] as String
  );
 }



 //note -> map
 Map<String,dynamic> toMap(){
   return {
     'content':content,
     'user_id': userId,
   };
 }
}
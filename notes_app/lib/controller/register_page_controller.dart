import 'package:flutter/material.dart';
import 'package:notes_app/layouts/bottom_navbar_layout.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPageController {
    final SupabaseClient _supabase= Supabase.instance.client;

  Future<void> register(String email, String password,BuildContext context) async{
    try{
      final response = await _supabase.auth.signUp(password: password, email: email);

      if(response.user != null){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavbarLayout()),
        );
      }      
    }on AuthException catch(e){
      print('Authentication error: ${e.message}');
      //show error message
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: const Text('Error'),
        content: Text(e.message),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ));
  }catch(e){
    print('Unexpected error: $e');
    //show error message
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text('Error'),
      content: const Text('An unexpected error occurred'),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    ));
  }
  }
}
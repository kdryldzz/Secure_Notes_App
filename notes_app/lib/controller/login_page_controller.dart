import 'package:flutter/material.dart';
import 'package:notes_app/layouts/bottom_navbar_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPageController {
final SupabaseClient _supabase = Supabase.instance.client;
//login function
Future<void> login(String email, String password, BuildContext context) async {
  if (email.isEmpty || password.isEmpty) {
    //show error message
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text('Error'),
      content: const Text('Please fill in all fields'),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    ));
    return;
  }
  else{
  try {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BottomNavbarLayout()),
      );
    }
    } on AuthException catch (e) {
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
    } catch (e) {
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

}
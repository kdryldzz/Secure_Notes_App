import 'package:flutter/material.dart';
import 'package:notes_app/view/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePageController {
final SupabaseClient _supabase = Supabase.instance.client;

//logout user
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
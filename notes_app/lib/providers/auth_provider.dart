import 'package:flutter/material.dart';
import 'package:notes_app/layouts/bottom_navbar_layout.dart';
import 'package:notes_app/view/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
//register function
  Future<void> register(String email, String password, BuildContext context) async {
    try {
      final response = await _supabase.auth.signUp(password: password, email: email);

      if (response.user != null) {
        notifyListeners();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavbarLayout()),
        );
      }
    } on AuthException catch (e) {
      print('Authentication error: ${e.message}');
      notifyListeners();
      // show error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(e.message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Unexpected error: $e');
      notifyListeners();
      // show error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An unexpected error occurred'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
//login function
Future<void> login(String email, String password, BuildContext context) async {
  if (email.isEmpty || password.isEmpty) {
    notifyListeners();
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
      notifyListeners();
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BottomNavbarLayout()),
      );
    }
    } on AuthException catch (e) {
    print('Authentication error: ${e.message}');
    notifyListeners();
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
    notifyListeners();
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
 //logout function
  Future<void> logout(BuildContext context) async {
    try{
      await _supabase.auth.signOut();
      notifyListeners();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
    }catch(e){
      print('Unexpected error: $e');
      notifyListeners();
    }
  }
}
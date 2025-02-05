import 'package:flutter/material.dart';
import 'package:notes_app/layouts/bottom_navbar_layout.dart';
import 'package:notes_app/view/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    final stream = Supabase.instance.client.auth.onAuthStateChange;
    return StreamBuilder(
      stream:stream,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      final session = snapshot.hasData ? snapshot.data!.session : null;
      if(session !=null){
      return BottomNavbarLayout(
      );
      }else{
      return LoginPage();
      }
      },
    );
  }
}
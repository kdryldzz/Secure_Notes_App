import 'package:flutter/material.dart';
import 'package:notes_app/layouts/bottom_navbar_layout.dart';
import 'package:notes_app/view/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://mwntcxanmdyxktidzkyl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im13bnRjeGFubWR5eGt0aWR6a3lsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc4ODExMDIsImV4cCI6MjA1MzQ1NzEwMn0.loFIITVweuUjk0BAZ2_tDQbKEOGsjYsSUlt3-r1rfys',
  );
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isLoggedIn ? const BottomNavbarLayout() : const LoginPage(),
    );
  }
}
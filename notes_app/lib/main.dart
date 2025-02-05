import 'package:flutter/material.dart';
import 'package:notes_app/providers/auth_provider.dart';
import 'package:notes_app/providers/database_provider.dart';
import 'package:notes_app/services/auth_gate.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://mwntcxanmdyxktidzkyl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im13bnRjeGFubWR5eGt0aWR6a3lsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc4ODExMDIsImV4cCI6MjA1MzQ1NzEwMn0.loFIITVweuUjk0BAZ2_tDQbKEOGsjYsSUlt3-r1rfys',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>AuthProvider()),
        ChangeNotifierProvider(create: (context)=>DatabaseProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AuthGate(),
      ),
    );
  }
}
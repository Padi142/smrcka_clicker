import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smrcka_clicker/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize database
  await Supabase.initialize(
      url: const String.fromEnvironment('SUPABASE_URL'),
      anonKey: const String.fromEnvironment('SUPABASE_SECRET'),
      authCallbackUrlHostname: 'login-callback', // optional
      debug: true // optional
      );

  runApp(const SmrckaClickerApp());
}

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smrcka_clicker/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Initialize variables
  await dotenv.load(fileName: ".env");

  //Initialize database
  await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'],
      anonKey: dotenv.env['SUPABASE_SECRET'],
      authCallbackUrlHostname: 'login-callback', // optional
      debug: true // optional
      );

  runApp(const SmrckaClickerApp());
}

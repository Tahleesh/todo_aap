import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_page.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),

      child: MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage()),
    ),
  );
}

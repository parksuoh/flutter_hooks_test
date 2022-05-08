import 'package:flutter/material.dart';
import 'package:popolsuoh/provider/chat_provider.dart';
import 'package:popolsuoh/provider/login_provider.dart';
import 'package:popolsuoh/screen/login/login_screen.dart';
import 'package:popolsuoh/screen/login/register_screen.dart';
import 'package:popolsuoh/screen/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(create: (context) => LoginProvider()),
        ChangeNotifierProvider<ChatProvider>(create: (context) => ChatProvider()),
      ],
      child: MaterialApp(
        title: 'suohpopol',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0.0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        home: LoginScreen(),
      ),
    );
  }
}

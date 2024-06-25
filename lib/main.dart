import 'package:flutter/material.dart';
import 'package:flutter_wallet_app_ui/screens/wallet_home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: const Key('myApp'), // Key for testing.
      debugShowCheckedModeBanner: false,
      title: 'Flutter Wallet App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.poppinsTextTheme(), // Use Google Fonts for text theme.
      ),
      home: const WalletHome(), // Set WalletHome as the initial screen.
    );
  }
}

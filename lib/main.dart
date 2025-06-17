import 'package:flutter/material.dart';
import './screen/homeScreen.dart';
import './screen/addDonor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donation App',
      routes: {
        "/": (context) => const Homescreen(),
        "/addDonor": (context) => const AddDonorScreen(),
      },
      initialRoute: "/",
    );
  }
}

import 'package:flutter/material.dart';
import './screen/homeScreen.dart';
import './screen/addDonor.dart';
import './screen/updateDonor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  //--------firebase setup-----------
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        "/updateDonor": (context) => const UpdateDonorScreen(),
      },
      initialRoute: "/",
    );
  }
}

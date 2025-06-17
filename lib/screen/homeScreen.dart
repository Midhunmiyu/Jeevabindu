import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JeevaBindu", style: TextStyle(fontSize: 30, fontFamily: 'Caprasimo')),
        backgroundColor: Colors.red,
        centerTitle: true,
        elevation: 50,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/addDonor");
          },
          child: Icon(
            Icons.add,
            size: 30,
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          tooltip: "Add Donor",
        ),
      ),
    );
  }
}

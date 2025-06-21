import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDonorScreen extends StatefulWidget {
  const UpdateDonorScreen({super.key});

  @override
  State<UpdateDonorScreen> createState() => _UpdateDonorScreenState();
}

class _UpdateDonorScreenState extends State<UpdateDonorScreen> {
  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String? selectedGroup;

  final CollectionReference donor = FirebaseFirestore.instance.collection("donor");
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();
  void updateDonor(docId) {
    final data = {
      "name": donorName.text,
      "phone": donorPhone.text,
      "group": selectedGroup,
    };
    donor.doc(docId).update(data).then((onValue) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    donorName.text = args["name"];
    donorPhone.text = args["phone"];
    selectedGroup = args["group"];
    final docId = args["id"];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "JeevaBindu",
          style: TextStyle(fontSize: 30, fontFamily: 'Caprasimo'),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
        elevation: 50,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Update Donor Details",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: donorName,
                decoration: const InputDecoration(
                    labelText: "Enter Donor Name",
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: donorPhone,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                    labelText: "Enter Phone Number",
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.phone),
                    prefixText: "+91-",
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedGroup,
                decoration: const InputDecoration(
                    labelText: "Select Blood Group",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                items: bloodGroups
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedGroup = val;
                  });
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 6, 109, 243),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  updateDonor(docId);
                },
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

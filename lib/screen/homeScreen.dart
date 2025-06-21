import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final CollectionReference donor = FirebaseFirestore.instance.collection("donor");
  void deleteDonor(docId) {
    donor.doc(docId).delete();
  }

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
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          tooltip: "Add Donor",
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: donor.orderBy("name").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot donorSnap = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: const Color.fromARGB(255, 230, 227, 227), blurRadius: 10, spreadRadius: 15)
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 30,
                                  child: Text(
                                    donorSnap["group"],
                                    style: TextStyle(fontSize: 25, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text(
                                donorSnap["name"],
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "+91-${donorSnap["phone"]}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/updateDonor", arguments: {
                                      "name": donorSnap["name"],
                                      "phone": donorSnap["phone"].toString(),
                                      "group": donorSnap["group"],
                                      "id": donorSnap.id,
                                    });
                                  },
                                  icon: Icon(Icons.edit),
                                  iconSize: 30,
                                  color: Colors.blue,
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteDonor(donorSnap.id);
                                  },
                                  icon: Icon(Icons.delete),
                                  iconSize: 30,
                                  color: Colors.red,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Container();
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myalo_app/treatment_method_2/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'doctor_tile.dart';
import 'package:myalo_app/login/login.dart'; // Make sure to import the login page

class DoctorList extends StatefulWidget {
  @override
  State<DoctorList> createState() => _DoctorList();
}

class _DoctorList extends State<DoctorList> {
  List<Doctor> questionList = getDoctorList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            // Search bar
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),

            // Message
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Choose your mental health inspector',
                // style: TextStyle(color: Colors.grey[600]),
              ),
            ),

            // Doctor list
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: questionList.length,
                itemBuilder: (context, index) {
                  Doctor doctor = questionList[index];
                  return InkWell(
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Thank you for selecting!"),
                          content: Text("Please wait..."),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await FirebaseAuth.instance.signOut();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: DocTile(doctor: doctor),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myalo_app/treatment_method_2/doctor_model.dart';

import 'doctor_tile.dart';

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
          //searchbar
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

          //message
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'Choose your mental health inspector',
              // style: TextStyle(color: Colors.grey[600]),
            ),
          ),

          //doc list
          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              Doctor doctor = getDoctorList()[index];
              return DocTile(doctor: doctor);
            }),
          ),
        ],
      ),
    ));
  }
}

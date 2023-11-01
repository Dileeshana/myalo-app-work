import 'package:flutter/material.dart';

import 'doctor_model.dart';

// ignore: must_be_immutable
class DocTile extends StatelessWidget {
  Doctor doctor;
  DocTile({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(),
      width: 150,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 119, 119, 119), width: 0.5, style: BorderStyle.solid)
      ),
      child: Row(
        children: [
          //doc pic
          ClipRRect(
            borderRadius: BorderRadius.circular(55),
            child: Image.asset(doctor.imagePath, width: 25),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 5)),
          //name
          Text(
            doctor.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
          //description
          Text(
            doctor.description, style: TextStyle(fontSize: 5, fontStyle: FontStyle.italic, fontWeight: FontWeight.w100),
          ),

          //ratings
        ],
      ),
    );
  }
}

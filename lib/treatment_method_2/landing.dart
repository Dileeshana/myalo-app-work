import 'package:flutter/material.dart';

import 'doctor_list.dart';

class HighSeverityLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  height: 80,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 65, horizontal: 35),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(221, 73, 73, 73)),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(text: "Let's start your\n"),
                            TextSpan(text: "Consultation\n"),
                          ]
                        )
                        ),
                    ],
                  )
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  alignment: Alignment.center,
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[300],
                  ),
                  child: Text(
                    "!",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),),
            _choseMentalInstructor(context),
          // Container(
          //   width: 250,
          //   height: 60,
          //   alignment: Alignment.center,
          //   margin: EdgeInsets.symmetric(vertical: 65, horizontal: 35),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Color.fromARGB(221, 122, 122, 122)),
          //     borderRadius: BorderRadius.circular(5)
          //   ),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [RichText(
          //         text: TextSpan(
          //           style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
          //           children: [
          //             TextSpan(text: "Chose a mental Inspector"),
          //           ]
          //         )
          //         ),
          //     ],
          //   )
          // ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Container(
                height: 150,
                width: 150,
                child: Image.asset(
                  'lib/images/Pray-amico.png'
                ),
              ),
            ),
            )
        ],
      ),
    );
  }

  _choseMentalInstructor(BuildContext context) {
     return Container(
      width: 250,
      height: 60,
      child: ElevatedButton(
        child: Text(
          "Chose a mental Inspector",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
            shape: LinearBorder(),
            primary: Color.fromARGB(246, 209, 209, 209),
            onPrimary: Colors.black
            ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DoctorList()));
        },
      ),
    );
  }
}
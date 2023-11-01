import 'package:flutter/material.dart';

class TreatOneLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white30,
        elevation: 0,
        title: Center(
          child: Text(
            "Schizophrenia Activity",
            style: TextStyle(
              color: Colors.black
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 300,
                width: 300,
                child: Image.asset(
                  'lib/images/meditating1.jpg'
                  ),
                ),
              Container(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  child: Text("Welcome"),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: Colors.blue.shade600,
                    onPrimary: Color.fromARGB(230, 255, 255, 255),
                  ),
                  onPressed: () {  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
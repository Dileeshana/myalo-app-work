import 'package:flutter/material.dart';

class SocialAnxietyMarks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 75),
            child: Text(
              "You have earned",
              style: TextStyle(
                color: Colors.black, 
                fontSize: 25,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          Container(
            width: 100,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromARGB(95, 189, 189, 189),
              ),
            child: Text(
              "78 %",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 7),
            child: Text(
              "Marks",
              // style: TextStyle(),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: ElevatedButton(
                    child: Text("New Attempt", style: TextStyle(color: Colors.black),),
                    style: ElevatedButton.styleFrom(
                      shape: LinearBorder(),
                      backgroundColor: Color.fromARGB(99, 168, 168, 168),
                      elevation: 0
                    ),
                    onPressed: () {}
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    child: Text("Download", style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      shape: LinearBorder(),
                      backgroundColor: Colors.blue[600],
                      elevation: 0
                    ),
                    onPressed: () {}
                  ),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
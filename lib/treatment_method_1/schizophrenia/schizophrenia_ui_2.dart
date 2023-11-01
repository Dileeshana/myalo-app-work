import 'package:flutter/material.dart';

class SchizophreniaSecPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            width: 250,
            height: 60,
            color: Color.fromARGB(33, 236, 236, 236),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Instructions to wear IOT device",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                      )
                    ),
                ]
              ),
              )
          ),
          Container(
            height: 200,
            width: 200,
            child: Image.asset(
              'lib/images/Candle.png'
              ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // width: 60,
                  height: 40,
                  child: Row(
                    children: [
                      Text(
                        '63 bpm ',
                        // style: TextStyle(
                        //   fontSize: 
                        // ),
                      ),
                      Image.asset(
                        'lib/images/pulse.png',
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Container(
                  // width: 40,
                  height: 40,
                  child: Row(
                    children: [
                      Text(
                        '9:48 ',
                        // style: TextStyle(
                        //   fontSize: 
                        // ),
                      ),
                      Image.asset(
                        'lib/images/wall-clock.png',
                        height: 30,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
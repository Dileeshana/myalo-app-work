import 'package:flutter/material.dart';

import 'relevent_cog_distrotion.dart';

class SocialAnxietyDistrotion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 45, horizontal: 35),
                  child: Column(
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                              children: [
                            TextSpan(text: "How do you\n"),
                            TextSpan(text: "feel ?")
                          ]))
                    ],
                  ),
                ),
                Container(
                  child: ElevatedButton(
                      child: Text(
                        "?",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(shape: CircleBorder()),
                      onPressed: () {}),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                    height: 30,
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                                children: [
                              TextSpan(text: "Mind Reading......."),
                              // TextSpan(text: ">")
                            ])),
                        Text(
                          ">",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        )
                      ],
                    )),
                Container(
                    height: 30,
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                                children: [
                              TextSpan(text: "Catastrophizing......."),
                              // TextSpan(text: ">")
                            ])),
                        Text(
                          ">",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        )
                      ],
                    )),
                Container(
                    height: 30,
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                                children: [
                              TextSpan(text: "Personolization......."),
                              // TextSpan(text: ">")
                            ])),
                        Text(
                          ">",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        )
                      ],
                    )),
                Container(
                    height: 30,
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                                children: [
                              TextSpan(
                                  text: "All - or - Nothing thinking......."),
                              // TextSpan(text: ">")
                            ])),
                        Text(
                          ">",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        )
                      ],
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReleventDistrotion()));
                  },
                  child: Container(
                      height: 30,
                      width: 300,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15,
                                  ),
                                  children: [
                                TextSpan(text: "Negative Self-labeling......."),
                                // TextSpan(text: ">")
                              ])),
                          Text(
                            ">",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                            ),
                          )
                        ],
                      )),
                ),
                Container(
                    height: 30,
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                                children: [
                              TextSpan(text: "Over generalization......."),
                              // TextSpan(text: ">")
                            ])),
                        Text(
                          ">",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        )
                      ],
                    )),
                Container(
                    height: 30,
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                                children: [
                              TextSpan(text: "Filtering......."),
                              // TextSpan(text: ">")
                            ])),
                        Text(
                          ">",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        )
                      ],
                    )),
                Container(
                    height: 30,
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                                children: [
                              TextSpan(text: "Emotional Reasoning......."),
                              // TextSpan(text: ">")
                            ])),
                        Text(
                          ">",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        )
                      ],
                    )),
                Container(
                    height: 30,
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                                children: [
                              TextSpan(text: "Fortune- Telling......."),
                              // TextSpan(text: ">")
                            ])),
                        Text(
                          ">",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        )
                      ],
                    )),
                Container(
                    height: 30,
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                                children: [
                              TextSpan(text: "Disqualifying the posil......."),
                              // TextSpan(text: ">")
                            ])),
                        Text(
                          ">",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

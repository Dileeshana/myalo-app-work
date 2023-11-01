import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:myalo_app/treatment_method_1/acrophobia/vrPlayer/vr_player.dart';

const platform = MethodChannel('com.myalodomain.vrchannel');

class AcrophobiaLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 45, horizontal: 25),
                    // color: Colors.black,
                    child: Column(
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                children: [
                              TextSpan(text: "Worried about\n"),
                              TextSpan(text: "your\n"),
                              TextSpan(text: "Fear of Heights?")
                            ])),
                      ],
                    )),
                Container(
                  color: Colors.blue[300],
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  child: Text(
                    "1",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 60,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
              // color: Colors.blue,
              margin: EdgeInsets.symmetric(vertical: 11),
              alignment: Alignment.center,
              child: Column(
                children: [
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          children: [
                        TextSpan(text: "`Let's Restructure\n"),
                        TextSpan(text: "       your Mind`")
                      ]))
                ],
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Container(
                height: 250,
                width: 250,
                child: Image.asset('lib/images/acrophobia1.png'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 40),
            width: 150,
            height: 50,
            child: ElevatedButton(
                child: Text("Get Started"),
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                onPressed: () async {
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) => VrPlayerPage()));
                  await platform.invokeMethod('launchVR', {'contentPath': 'lib/images/panaroma.jpg'});
                }),
          ),
        ],
      ),
    );
  }
}

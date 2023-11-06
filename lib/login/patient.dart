import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:myalo_app/identifiyng_quiz/identify_quiz.dart';
import 'package:myalo_app/login/appointments.dart';
import 'package:myalo_app/login/diary.dart';
import 'package:myalo_app/login/login.dart';
import 'package:myalo_app/login/messages.dart';
import 'package:myalo_app/login/chatbot.dart';

class Patient extends StatefulWidget {
  final Map<Object?, Object?> userData;

  const Patient(this.userData);

  @override
  State<Patient> createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  final _noteController = TextEditingController();
  final _messageController = TextEditingController();
  DateTime? selectedAppointmentDate;
  String? selectedAppointmentTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Display the patient's name at the top
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Hi,  ${widget.userData['firstname']} ${widget.userData['lastname']}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // 2 columns
              children: <Widget>[
                _buildTile("Take the Test", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IdentifyQuiz()),
                  );
                }),
                _buildTile("Diary", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Diary(widget.userData)),
                  );
                }),
                _buildTile("Appointments", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Appointments(widget.userData)),
                  );
                }),
                _buildTile("Messages", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Messages(widget.userData)),
                  );
                }),
                // _buildTile("Chatbot", () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => ChatbotScreen()),
                //   );
                // }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(String title, VoidCallback onPressed) {
    return Card(
      color: Colors.orange,
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("Patient"),
  //       actions: [
  //         IconButton(
  //           onPressed: () {
  //             logout(context);
  //           },
  //           icon: Icon(
  //             Icons.logout,
  //           ),
  //         )
  //       ],
  //     ),
  //     body: Column(
  //       children: [
  //         Center(
  //           child: Text(
  //             'Patient Name: ${widget.userData['firstname']} ${widget.userData['lastname']}',
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: TextField(
  //             controller: _noteController,
  //             decoration: InputDecoration(
  //               labelText: 'Enter your note for today',
  //               border: OutlineInputBorder(),
  //             ),
  //             maxLines: 5,
  //           ),
  //         ),
  //         ElevatedButton(
  //           onPressed: _submitNote,
  //           child: Text('Submit Note'),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: TextField(
  //             controller: _messageController,
  //             decoration: InputDecoration(
  //               labelText: 'Send a message to your doctor',
  //               border: OutlineInputBorder(),
  //             ),
  //             maxLines: 3,
  //           ),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //             sendMessage(widget.userData['currentDoctorId'].toString(),
  //                 _messageController.text);
  //           },
  //           child: Text('Send Message'),
  //         ),
  //         Expanded(
  //           child: StreamBuilder<QuerySnapshot>(
  //             stream: getMessages(),
  //             builder: (context, snapshot) {
  //               if (snapshot.connectionState == ConnectionState.waiting) {
  //                 return CircularProgressIndicator();
  //               }
  //               if (!snapshot.hasData) {
  //                 return Text('No messages yet.');
  //               }
  //               final messages = snapshot.data!.docs;
  //               return ListView.builder(
  //                 itemCount: messages.length,
  //                 itemBuilder: (context, index) {
  //                   return ListTile(
  //                     title: Text(messages[index]['content']),
  //                     subtitle: Text(
  //                         messages[index]['timestamp'].toDate().toString()),
  //                   );
  //                 },
  //               );
  //             },
  //           ),
  //         ),
  //         // Appointment Scheduler
  //         ElevatedButton(
  //           onPressed: _selectAppointmentDate,
  //           child: Text('Select Appointment Date'),
  //         ),
  //         if (selectedAppointmentDate != null) ...[
  //           _buildAvailableTimesDropdown(),
  //           if (selectedAppointmentTime != null) ...[
  //             ElevatedButton(
  //               onPressed: _bookAppointment,
  //               child: Text('Book Appointment'),
  //             ),
  //           ],
  //         ],
  //       ],
  //     ),
  //   );
  // }

  // Future<void> _submitNote() {
  //   if (_noteController.text.isNotEmpty) {
  //     final newNote = _noteController.text;
  //     final databaseReference = FirebaseDatabase.instance.reference();

  //     databaseReference
  //         .child('users')
  //         .orderByChild('userId')
  //         .equalTo(widget.userData['userId'].toString())
  //         .once()
  //         .then((DatabaseEvent event) {
  //       DataSnapshot snapshot = event.snapshot;
  //       print("Snapshot Value: ${snapshot.value}");

  //       Map<dynamic, dynamic>? usersData;
  //       if (snapshot.value is Map) {
  //         usersData = snapshot.value as Map<dynamic, dynamic>;
  //       } else if (snapshot.value is List) {
  //         usersData = Map.fromIterable((snapshot.value as List).asMap().entries,
  //             key: (e) => e.key.toString(), value: (e) => e.value);
  //       }

  //       if (usersData != null) {
  //         String userKey = usersData.keys.first;
  //         Map<dynamic, dynamic> specificUserData = usersData[userKey];

  //         if (specificUserData != null) {
  //           var dairyKey = databaseReference.child('dairy').push().key;

  //           if (dairyKey != null) {
  //             databaseReference
  //                 .child('users')
  //                 .child(widget.userData['userId'].toString())
  //                 .child('dairy')
  //                 .child(dairyKey)
  //                 .set(newNote)
  //                 .then((_) {
  //               setState(() {
  //                 _noteController.clear();
  //               });
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(content: Text('Note added successfully!')));
  //             }).catchError((error) {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(content: Text('Failed to add note: $error')));
  //             });
  //           } else {
  //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                 content: Text('Failed to generate a key for the note.')));
  //           }
  //         } else {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text('Failed to fetch specific user data.')));
  //         }
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('Failed to parse user data.')));
  //       }
  //     });
  //   }
  //   return Future.value();
  // }

  // New methods for the messaging feature

  // Future<void> sendMessage(String receiverId, String content) async {
  //   var user = FirebaseAuth.instance.currentUser;
  //   await FirebaseFirestore.instance.collection('messages').add({
  //     'senderId': user!.uid,
  //     'receiverId': receiverId,
  //     'content': content,
  //     'timestamp': FieldValue.serverTimestamp()
  //   });
  //   _messageController.clear();
  // }

  // Stream<QuerySnapshot> getMessages() {
  //   var user = FirebaseAuth.instance.currentUser;
  //   return FirebaseFirestore.instance
  //       .collection('messages')
  //       .where('receiverId', isEqualTo: user!.uid)
  //       .orderBy('timestamp', descending: true)
  //       .snapshots();
  // }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}

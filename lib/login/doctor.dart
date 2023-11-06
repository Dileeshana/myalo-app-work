import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myalo_app/identifiyng_quiz/quiz_model.dart'; // Ensure this import is correct for your project
import 'login.dart';

class Doctor extends StatefulWidget {
  final Map<Object?, Object?> userData;

  Doctor(this.userData);

  @override
  State<Doctor> createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  List<Map<dynamic, dynamic>> patients = [];
  final _replyController = TextEditingController();

  DateTime? selectedDate;
  List<String> availableTimes = [];
  final timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPatientsFromFirebase().then((fetchedPatients) {
      setState(() {
        patients = fetchedPatients;
      });
    });
  }

  Future<List<Map<dynamic, dynamic>>> fetchPatientsFromFirebase() async {
    final databaseReference = FirebaseDatabase.instance.reference();
    List<Map<dynamic, dynamic>> fetchedPatients = [];
    await databaseReference
        .child('users')
        .orderByChild('userType')
        .equalTo('Patient')
        .once()
        .then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      List<Object?> values = snapshot.value as List<Object?>;

      for (Object? element in values) {
        if (element is Map<Object?, Object?>) {
          final Map<Object?, Object?> mapElement = element;
          fetchedPatients.add(mapElement as Map<dynamic, dynamic>);
        }
      }
    });

    return fetchedPatients;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor"),
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
        children: [
          Text(
            'Doctor Name: ${widget.userData['firstname']} ${widget.userData['lastname']}',
          ),
          Expanded(child: _buildPatientList()),
          Expanded(child: _buildMessageList()),
          _buildAvailabilitySetter(),
          _buildScheduledAppointments(),
        ],
      ),
    );
  }

  Widget _buildPatientList() {
    if (patients.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: patients.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              'Patient Name: ${patients[index]['firstname']} ${patients[index]['lastname']}',
            ),
            subtitle: Text('Email: ${patients[index]['email']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PatientDiaryScreen(patientData: patients[index]),
                ),
              );
            },
          );
        },
      );
    }
  }

  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: getMessages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (!snapshot.hasData) {
          return Text('No messages yet.');
        }
        // print("SNAP:: ${snapshot}");
        final messages = snapshot.data!.docs;

        return Container(
          height: 250, // specify the height you want
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(messages[index]['content']),
                subtitle:
                    Text(messages[index]['timestamp'].toDate().toString()),
                trailing: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Reply to Message"),
                          content: TextField(
                            controller: _replyController,
                            decoration: InputDecoration(
                              labelText: 'Enter your reply',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                          ),
                          actions: [
                            TextButton(
                              child: Text("Send"),
                              onPressed: () {
                                sendMessage(messages[index]['senderId'],
                                    _replyController.text);
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Reply'),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Stream<QuerySnapshot> getMessages() {
    var user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('messages')
        .where('receiverId', isEqualTo: user!.uid)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> sendMessage(String receiverId, String content) async {
    var user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('messages').add({
      'senderId': user!.uid,
      'receiverId': receiverId,
      'content': content,
      'timestamp': FieldValue.serverTimestamp()
    });
    _replyController.clear();
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  Widget _buildAvailabilitySetter() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _selectDate,
          child: Text("Select Date for Availability"),
        ),
        if (selectedDate != null) ...[
          TextField(
            controller: timeController,
            decoration: InputDecoration(
              labelText: "Enter available time (e.g. 10:00 AM)",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                availableTimes.add(timeController.text);
                timeController.clear();
              });
            },
            child: Text("Add Time"),
          ),
          ElevatedButton(
            onPressed: _saveAvailability,
            child: Text("Save Availability"),
          ),
        ],
        Text("Selected Date: ${selectedDate?.toLocal()}"),
        Text("Available Times: ${availableTimes.join(", ")}"),
      ],
    );
  }

  Future<void> _selectDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> _saveAvailability() async {
    if (selectedDate != null && availableTimes.isNotEmpty) {
      FirebaseFirestore.instance.collection('availability').add({
        'doctorId': FirebaseAuth.instance.currentUser!.uid,
        'date': selectedDate,
        'times': availableTimes,
      });

      setState(() {
        selectedDate = null;
        availableTimes.clear();
      });
    }
  }

  // Widget _buildScheduledAppointments() {
  //   // This function will fetch and display the appointments scheduled by patients
  //   // Placeholder for now
  //   return Text("Scheduled Appointments go here");
  // }

  Widget _buildScheduledAppointments() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('appointments')
          .where('doctorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No scheduled appointments.');
        }

        final appointments = snapshot.data!.docs;
        return ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Patient ID: ${appointments[index]['patientId']}'),
              subtitle: Text(
                  'Date: ${appointments[index]['date'].toDate().toString()} Time: ${appointments[index]['time']}'),
            );
          },
        );
      },
    );
  }
}

class PatientDiaryScreen extends StatelessWidget {
  final Map<dynamic, dynamic> patientData;

  PatientDiaryScreen({required this.patientData});

  @override
  Widget build(BuildContext context) {
    List<Object?> diaryEntries = patientData['dairy'] as List<Object?>;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Patient Diary of ${patientData['firstname']} ${patientData['lastname']}"),
      ),
      body: ListView.builder(
        itemCount: diaryEntries.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(diaryEntries[index].toString()),
          );
        },
      ),
    );
  }
}

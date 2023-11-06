import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Appointments extends StatefulWidget {
  final Map<Object?, Object?> userData;

  const Appointments(this.userData);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  DateTime? selectedAppointmentDate;
  String? selectedAppointmentTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _selectAppointmentDate,
              child: Text('Select Appointment Date'),
            ),
            if (selectedAppointmentDate != null) ...[
              _buildAvailableTimesDropdown(),
              if (selectedAppointmentTime != null) ...[
                ElevatedButton(
                  onPressed: _bookAppointment,
                  child: Text('Book Appointment'),
                ),
              ],
            ],
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }

  Future<void> _selectAppointmentDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (date != null) {
      setState(() {
        selectedAppointmentDate = date;
      });
    }
  }

  Widget _buildAvailableTimesDropdown() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('availability')
          .where('doctorId', isEqualTo: widget.userData['currentDoctorId'])
          .where('date', isEqualTo: selectedAppointmentDate)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No available times for this date.');
        }
        final availabilityData = snapshot.data!.docs.first.data();
        final times = List<String>.from(
            (availabilityData as Map<String, dynamic>)?['times'] ?? []);

        return DropdownButton<String>(
          hint: Text("Select Time"),
          value: selectedAppointmentTime,
          items: times.map((time) {
            return DropdownMenuItem<String>(
              value: time,
              child: Text(time),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedAppointmentTime = newValue!;
            });
          },
        );
      },
    );
  }

  Future<void> _bookAppointment() async {
    if (selectedAppointmentDate != null && selectedAppointmentTime != null) {
      // Code to save the appointment in your database
      // For simplicity, this is a placeholder
      print(
          'Appointment booked for $selectedAppointmentDate at $selectedAppointmentTime');
      setState(() {
        selectedAppointmentDate = null;
        selectedAppointmentTime = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Appointment booked successfully!')));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Diary extends StatefulWidget {
  final Map<Object?, Object?> userData;

  const Diary(this.userData);

  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diary'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _noteController,
                decoration: InputDecoration(
                  labelText: 'Enter your note for today',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
            ),
            ElevatedButton(
              onPressed: _submitNote,
              child: Text('Submit Note'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitNote() async {
    if (_noteController.text.isEmpty) return;

    final newNote = _noteController.text;
    final databaseReference = FirebaseDatabase.instance.reference();

    try {
      var dairyKey = databaseReference.child('dairy').push().key;
      if (dairyKey == null) {
        throw Exception('Failed to generate a key for the note.');
      }

      await databaseReference
          .child('users')
          //.child(widget.userData['userId'].toString())
          .child('dairy')
          .child(dairyKey)
          .set(newNote);

      setState(() {
        _noteController.clear();
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Note added successfully!')));
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to add note: $error')));
    }
  }
}

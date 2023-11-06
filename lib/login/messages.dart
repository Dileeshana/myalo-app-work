import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatefulWidget {
  final Map<Object?, Object?> userData;

  const Messages(this.userData);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  int _counter = 0;
  final _messageController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Send a message to your doctor',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                sendMessage(widget.userData['currentDoctorId'].toString(),
                    _messageController.text);
              },
              child: Text('Send Message'),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: getMessages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (!snapshot.hasData) {
                    return Text('No messages yet.');
                  }
                  final messages = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(messages[index]['content']),
                        subtitle: Text(
                            messages[index]['timestamp'].toDate().toString()),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendMessage(String receiverId, String content) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('messages').add({
      'senderId': user!.uid,
      'receiverId': receiverId,
      'content': content,
      'timestamp': FieldValue.serverTimestamp()
    });
    _messageController.clear();
  }

  Stream<QuerySnapshot> getMessages() {
    var user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('messages')
        .where('receiverId', isEqualTo: user!.uid)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}

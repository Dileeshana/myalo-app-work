import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  final databaseReference =
      FirebaseDatabase.instance.reference().child('chatbot_responses');

  // final List<String> suggestionQuestionsPreview = [
  //   "Mind Reading",
  //   "Catastrophizing",
  //   "Personalization",
  //   "All-or-Nothing Thinking",
  //   "Negative Self-Labeling",
  //   "Overgeneralization",
  //   "Filtering",
  //   "Emotional Reasoning",
  //   "Fortune-Telling",
  //   "Disqualifying the Postive",
  // ];

  final List<String> suggestionQuestions = [
    "Do I have solid evidence to support my belief about what others are thinking?",
    "What alternative explanations could there be for someone's behavior or words?",
    "How can I verify my assumptions through communication or clarification?",
    "Am I blowing things out of proportion? How likely is the worst-case scenario?",
    "What evidence supports the idea that I'm making a small issue into a huge problem?",
    "How would I advise a friend or loved one who is facing a similar situation?",
    "Am I assuming responsibility for something that is beyond my control?",
    "What evidence suggests that I am attributing undue influence or significance to myself?",
    "How would my perspective change if I considered other factors or individuals involved?",
    "Is it possible that there are shades of gray in this situation?",
    "What evidence supports the idea that everything must be perfect or a complete failure?",
    "Can I think of any alternative outcomes that fall between the extremes?",
    "Am I using extreme labels or judgments without considering the full context?",
    "How does labeling myself or others impact my perception and behavior?",
    "Can I find alternative, more accurate descriptions that reflect the complexity of the situation?",
    "Am I making a broad conclusion based on just one or a few instances?",
    "Is there any evidence that contradicts my generalized belief?",
    "Can I consider alternative explanations or factors that might influence the outcome?",
    "Am I focusing only on the negative aspects while ignoring the positive ones?",
    "What evidence or experiences have I discounted or dismissed?",
    "How would my perspective change if I acknowledged both positive and negative aspects?",
    "Am I assuming that my emotions accurately reflect reality without considering other factors?",
    "What evidence supports or contradicts my emotional interpretation of the situation?",
    "How would my perspective change if I detached my emotions and examined the situation objectively?",
    "Am I imposing unrealistic expectations or demands on myself or others?",
    "What evidence supports the idea that things 'should' be a certain way?",
    "Can I reframe my expectations to be more flexible and realistic?",
    "What positive aspects or achievements am I minimizing or overlooking?",
    "How would someone else perceive the situation, considering the positive elements?",
    "What would happen if I gave equal weight to both positive and negative aspects?"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: _messages.length,
              separatorBuilder: (context, index) => SizedBox(height: 8.0),
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUserMessage = message.role == 'You';
                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.blue : Colors.green,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      message.content,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 50, // Adjust the height as needed
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: suggestionQuestions.map((question) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: ActionChip(
                    label: Text(question, style: TextStyle(fontSize: 12)),
                    onPressed: () {
                      _sendMessage(question);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    _sendMessage(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    if (text.isEmpty) return;
    setState(() {
      _messages.add(Message(role: "You", content: text));
      _controller.clear();
    });

    // Fetching response from Firebase
    databaseReference.child(text).once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        setState(() {
          _messages.add(
              Message(role: "Chatbot", content: snapshot.value.toString()));
        });
      } else {
        setState(() {
          _messages.add(Message(
              role: "Chatbot",
              content: "Sorry, I don't have a response for that."));
        });
      }
    });
  }
}

class Message {
  final String role;
  final String content;

  Message({required this.role, required this.content});
}

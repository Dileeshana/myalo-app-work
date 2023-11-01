// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class Functions {
//   static Future<Map<String, dynamic>> submitAnswers(Map<String, dynamic> answers) async {
//     final response = await http.post(
//       Uri.parse('http://10.0.2.2:5000/questions'), // Replace with backend URL
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(answers),
//     );

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to submit answers');
//     }
//   }
// }


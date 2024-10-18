import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotWidget extends StatefulWidget {
  @override
  _ChatbotWidgetState createState() => _ChatbotWidgetState();
}

class _ChatbotWidgetState extends State<ChatbotWidget> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  String _response = "";

  Future<void> _sendData() async {
    final height = _heightController.text;
    final weight = _weightController.text;
    final goal = _goalController.text;

    log("check");

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/chatbot'), // Your Flask API URL
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'height': height,
        'weight': weight,
        'query': goal,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _response = json.decode(response.body)['plan'].toString();
      });
    } else {
      setState(() {
        _response = "Error: ${response.statusCode}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Chatbot'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _heightController,
              decoration: InputDecoration(labelText: 'Height (cm)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight (kg)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _goalController,
              decoration: InputDecoration(labelText: 'Fitness Goal'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendData,
              child: Text('Get Fitness Plan'),
            ),
            SizedBox(height: 20),
            Text(
              'Response:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(_response),
          ],
        ),
      ),
    );
  }
}
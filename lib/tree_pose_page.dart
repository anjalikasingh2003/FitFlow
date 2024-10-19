import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TreePosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tree Pose'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the image
            Image.asset('assets/img_tree_pose.png'), // Ensure the path is correct

            SizedBox(height: 20), // Space between image and button

            // Display the Start button
            ElevatedButton(
              onPressed: () {
                _runTreePoseScript();
              },
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to run the Tree_pose.py script
  void _runTreePoseScript() async {
    try {
      final response = await http.get(Uri.parse('http://10.81.100.141:5000/run_tree_pose'));
      
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('STDOUT: ${jsonResponse['stdout']}');
        print('STDERR: ${jsonResponse['stderr']}');
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Error running script: $e');
    }
  }
}

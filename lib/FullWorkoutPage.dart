import 'package:flutter/material.dart';
import 'package:process_run/shell.dart'; // Ensure this import is at the top
import 'dart:async';

class FullWorkoutPage extends StatefulWidget {
  @override
  _FullWorkoutPageState createState() => _FullWorkoutPageState();
}

class _FullWorkoutPageState extends State<FullWorkoutPage> {
  String message = "You have to do 10 Pushups, 10 Jumping Jacks, 10 Squats";
  bool showMessage = true;

  @override
  void initState() {
    super.initState();
    // Set a timer to hide the message after 5 seconds
    Timer(Duration(seconds: 5), () {
      setState(() {
        showMessage = false;
      });
      // Start the exercise sequence
      executeExercises();
    });
  }

  Future<void> executeExercises() async {
    Shell shell = Shell();

    try {
      // Execute the Jumping Jacks script
      print("Starting Jumping Jacks...");
      await shell.run('python exercises/jumpingjacks.py');
      print("Completed Jumping Jacks.");

      // Execute the Squats script
      print("Starting Squats...");
      await shell.run('python exercises/squats.py');
      print("Completed Squats.");

      // Execute the Pushups script
      print("Starting Pushups...");
      await shell.run('python exercises/pushups.py');
      print("Completed Pushups.");

      // Optionally navigate back or display a completion message
      Navigator.pop(context); // Go back to the workout page
    } catch (e) {
      print("Error executing exercises: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Assistant'),
      ),
      body: Center(
        child: showMessage
            ? Text(
                message,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              )
            : Text(
                "Get ready to start your workout!",
                style: TextStyle(fontSize: 24),
              ),
      ),
    );
  }
}

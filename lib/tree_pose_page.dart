import 'package:flutter/material.dart';
import 'dart:io';

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
      // Make sure the path to the script is correct
      var result = await Process.run('python', ['yoga_poses/Tree_pose.py']);
      
      // Handle the output of the script
      print(result.stdout);
      print(result.stderr);

      if (result.exitCode != 0) {
        // If the script didn't run successfully, print the error
        print('Error running script: ${result.stderr}');
      }
    } catch (e) {
      print('Error running script: $e');
    }
  }
}

import 'package:flutter/material.dart';
import 'tree_pose_page.dart'; // Import the tree pose page
import 'triangle_page.dart'; // Import the triangle pose page
import 'plank_page.dart'; // Import the plank page

class YogaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yoga'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose Yoga Pose',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20), // Space between text and buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TreePosePage()),
                );
              },
              child: Text('Tree Pose'),
            ),
            SizedBox(height: 10), // Space between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrianglePage()),
                );
              },
              child: Text('Triangle'),
            ),
            SizedBox(height: 10), // Space between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlankPage()),
                );
              },
              child: Text('Plank'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:fir_n_flow/strength_training.dart';
import 'package:flutter/material.dart';
import 'cardio_page.dart';
import 'hiit_page.dart';

class WorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Select an Option:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to AI Assistant page (create this page later)
              },
              child: Text('Get AI Workout Plan'),
            ),
            SizedBox(height: 20),
            Text(
              'Or choose your workout type:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to Cardio page (create this page later)
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CardioPage()),
                );
              },
              child: Text('Cardio'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to Strength Training page (create this page later)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StrengthtrainingPage()),
                );
              },
              child: Text('Strength Training'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to HIIT page (create this page later)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HIITPage()),
                );
              },
              child: Text('High-Intensity Interval Training'),
            ),
          ],
        ),
      ),
    );
  }
}

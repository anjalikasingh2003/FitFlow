import 'package:flutter/material.dart';

class YogaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yoga'),
      ),
      body: Center(
        child: Text(
          'Workout plans will be displayed here.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

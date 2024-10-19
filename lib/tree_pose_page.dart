import 'package:flutter/material.dart';

class TreePosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tree Pose'),
      ),
      body: Center(
        child: Text(
          'Information about Tree Pose will be displayed here.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

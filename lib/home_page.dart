import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import Lottie
import 'package:animated_background/animated_background.dart'; // Import for animation
import 'workout_page.dart'; // Import the WorkoutPage
import 'yoga_page.dart'; // Import the YogaPage
import 'chat_bot.dart'; // Import the ChatbotWidget

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80, // Increase the height of the AppBar
        title: Container(
          alignment: Alignment.center, // Center the text
          child: Text(
            'WELCOME TO FITFLOW',
            style: TextStyle(
              fontSize: 24, // Font size
              fontWeight: FontWeight.bold, // Font weight
              color: Colors.white, // Text color
              letterSpacing: 1.5, // Letter spacing
              shadows: [
                Shadow(
                  blurRadius: 4.0,
                  color: Colors.black.withOpacity(0.5), // Shadow color
                  offset: Offset(2.0, 2.0), // Shadow position
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black, // AppBar background color
      ),
      body: Container(
        width: double.infinity, // Ensure container width fills the screen
        height: double.infinity, // Ensure container height fills the screen
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Circuit_Training.jpeg'),
            fit: BoxFit.cover, // Ensure image covers the entire container
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Select an Option',
                style: TextStyle(
                  fontSize: 32, // Increased font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40), // Increased spacing
              // Workout Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorkoutPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.transparent, // Make background transparent
                  elevation: 0, // Remove elevation for a flat look
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                    side: BorderSide(color: Colors.transparent), // Optional: Add a white border
                  ),
                ).copyWith(
                  overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(1)), // Change overlay color on hover/click
                ),
                child: Text(
                  'Workout',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white), // Increased font size and weight
                ),
              ),
              SizedBox(height: 20),
              // Yoga Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => YogaPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.transparent, // Make background transparent
                  elevation: 0, // Remove elevation for a flat look
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                    side: BorderSide(color: Colors.transparent), // Optional: Add a white border
                  ),
                ).copyWith(
                  overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(1)), // Change overlay color on hover/click
                ),
                child: Text(
                  'Yoga',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white), // Increased font size and weight
                ),
              ),
            ],
          ),
        ),
      ),
      // Floating Action Button for Chatbot with Lottie animation
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, right: 20.0), // Adjust position
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatbotWidget()),
            );
          },
          backgroundColor: Colors.blue, // Change the color as needed
          child: Stack(
            alignment: Alignment.center,
            children: [
              Lottie.asset('assets/chatbot_animation.json', width: 50, height: 50), // Add Lottie animation
              Positioned(
                bottom: 0,
                child: Text("How may I help you?", style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

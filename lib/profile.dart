// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:flutter/material.dart';

// class ProfiScreen extends StatelessWidget {
//   const ProfiScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.person),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute<ProfileScreen>(
//                 builder: (context) => ProfileScreen(
//                     appBar: AppBar(
//                      title: const Text('User Profile'),
//                    ),
//                     actions: [
//                       SignedOutAction((context) {
//                         Navigator.of(context).pop();
//                       })
//                     ],
//                   ),
//                 ),
//               );
//             },
//           )
//         ],
//         automaticallyImplyLeading: false,
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Text(
//               'Welcome!',
//               style: Theme.of(context).textTheme.displaySmall,
//             ),
//             const SignOutButton(),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import Lottie
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // Import Firebase Auth UI
import 'workout_page.dart'; // Import the WorkoutPage
import 'yoga_page.dart'; // Import the YogaPage
import 'chat_bot.dart'; // Import the ChatbotWidget

class ProfiScreen extends StatelessWidget {
  const ProfiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity, // Fullscreen width
        height: double.infinity, // Fullscreen height
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Circuit_Training.jpeg'), // Background image
            fit: BoxFit.cover, // Ensure the image covers the entire screen
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Welcome text at the top
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white, // White text color for visibility
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 20), // Spacing between the welcome text and options
            // Select an Option text
            Text(
              'Select an Option',
              style: TextStyle(
                fontSize: 32, // Font size for the "Select an Option"
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.7),
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40), // Spacing between "Select an Option" and buttons
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
                backgroundColor: Colors.transparent, // Transparent button background
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  side: BorderSide(color: Colors.transparent),
                ),
              ).copyWith(
                overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(1)),
              ),
              child: Text(
                'Workout',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
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
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  side: BorderSide(color: Colors.transparent),
                ),
              ).copyWith(
                overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(1)),
              ),
              child: Text(
                'Yoga',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
            SizedBox(height: 40), // Spacing before sign-out button
            // Sign out button
            const SignOutButton(),
          ],
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
                child: Text(
                  "How may I help you?",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CardioPage extends StatefulWidget {
  @override
  _CardioPageState createState() => _CardioPageState();
}

class _CardioPageState extends State<CardioPage> {
  final _controller = YoutubePlayerController();
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  bool isCameraInitialized = false;

  // Video IDs
  final List<String> videoIds = ["auBLPXO8Fww", "XPU9K9QM7ME","L8fvypPrzzs", "S7HEm-fd534"]; // Add your video IDs here
  int currentVideoIndex = 0;

  @override 
  void initState() { 
    super.initState(); 
    _controller.loadVideoById(videoId: videoIds[currentVideoIndex]);
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController?.initialize();
    setState(() {
      isCameraInitialized = true;
    });
  }

  void _startVideo() {
    _controller.playVideo();  // Use playVideo instead of play
   // _controller.setLoop(true); // Set the video to loop
  }

  void _stopVideo() {
    _controller.pauseVideo();  // Use pauseVideo instead of pause
  }

  void _nextVideo() {
    if (currentVideoIndex < videoIds.length - 1) {
      currentVideoIndex++;
    } else {
       _showWorkoutCompletedDialog(); // Show workout completed dialog
    }
    _controller.loadVideoById(videoId: videoIds[currentVideoIndex]);
    _startVideo(); // Automatically start the next video
  }

  void _showWorkoutCompletedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Workout Completed'),
          content: Text('Great job! You have completed this exercise.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // This will pop the dialog
                Navigator.pop(context); // This will pop the StrengthTrainingPage and go back
              },
              child: Text('Okay'),
            ),
          ],
        );
      },
    );
  }



  @override
  void dispose() {
    cameraController?.dispose();
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardio Workouts'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 160,
                    height: 120,
                    child: isCameraInitialized
                        ? CameraPreview(cameraController!)
                        : Center(child: CircularProgressIndicator()),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 300,
                    height: 200,
                    child: YoutubePlayer(
                      controller: _controller,
                      aspectRatio: 16 / 9,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startVideo,
                  child: Text('Start'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _stopVideo,
                  child: Text('Stop'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _nextVideo,
                  child: Text('Next'),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

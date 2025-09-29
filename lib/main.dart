import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: MyApp(),
    ),
  );
}

// Mood Model - The "Brain" of our app
class MoodModel with ChangeNotifier {
  // changed from emoji text to a real asset path (required for Image.asset)
  String _currentMood = 'assets/happy.webp';
  String get currentMood => _currentMood;

  void setHappy() {
    // changed to a String path + added missing semicolon
    _currentMood = 'assets/happy.webp';
    notifyListeners();
  }

  void setSad() {
    _currentMood = 'assets/sad.webp';
    notifyListeners();
  }

  void setExcited() {
    _currentMood = 'assets/excited.webp';
    notifyListeners();
  }
}

// Main App Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mood Toggle Challenge')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('How are you feeling?', style: TextStyle(fontSize: 24)),
            SizedBox(height: 30),
            MoodDisplay(),
            SizedBox(height: 50),
            MoodButtons(),
          ],
        ),
      ),
    );
  }
}

// Widget that displays the current mood
class MoodDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Image.asset(
          moodModel.currentMood,
          fit: BoxFit.cover,
          width: 220,
          height: 220,
        );
      },
    );
  }
}

// Widget with buttons to change the mood
class MoodButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setHappy();
          },
          child: Text('Happy 😊'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setSad();
          },
          child: Text('Sad 😢'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setExcited();
          },
          child: Text('Excited 🎉 use your own img here '),
        ),
      ],
    );
  }
}

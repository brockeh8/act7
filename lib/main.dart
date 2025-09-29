import 'dart:math';
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

// Mood Model
class MoodModel with ChangeNotifier {
  String _currentMood = 'assets/happy.webp';
  String get currentMood => _currentMood;

  Color _backgroundColor = Colors.yellow;
  Color get backgroundColor => _backgroundColor;

  final Map<String, int> _counts = {
    'Happy': 0,
    'Sad': 0,
    'Excited': 0,
  };
  Map<String, int> get counts => Map.unmodifiable(_counts);

  void setHappy() {
    _currentMood = 'assets/happy.webp';
    _backgroundColor = Colors.yellow;
    _counts['Happy'] = (_counts['Happy'] ?? 0) + 1;
    notifyListeners();
  }

  void setSad() {
    _currentMood = 'assets/sad.webp';
    _backgroundColor = Colors.blue;
    _counts['Sad'] = (_counts['Sad'] ?? 0) + 1;
    notifyListeners();
  }

  void setExcited() {
    _currentMood = 'assets/excited.webp';
    _backgroundColor = Colors.orange;
    _counts['Excited'] = (_counts['Excited'] ?? 0) + 1;
    notifyListeners();
  }

  void setRandomMood() {
    final moods = [setHappy, setSad, setExcited];
    moods[Random().nextInt(moods.length)]();
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


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Mood Toggle Challenge')),
          backgroundColor: moodModel.backgroundColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('How are you feeling?', style: TextStyle(fontSize: 24)),
                SizedBox(height: 30),
                MoodDisplay(),
                SizedBox(height: 50),
                MoodButtons(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<MoodModel>().setRandomMood();
                  },
                  child: Text('Random Mood 🤪'),
                ),
                SizedBox(height: 24),
                MoodCounter(),
              ],
            ),
          ),
        );
      },
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
            context.read<MoodModel>().setHappy();
          },
          child: Text('Happy 😊'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<MoodModel>().setSad();
          },
          child: Text('Sad 😢'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<MoodModel>().setExcited();
          },
          child: Text('Excited 🎉'),
        ),
      ],
    );
  }
}

class MoodCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, model, _) {
        final counts = model.counts;
        return Column(
          children: [
            Text('Happy: ${counts['Happy']}'),
            Text('Sad: ${counts['Sad']}'),
            Text('Excited: ${counts['Excited']}'),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class MoodLoggingScreen extends StatefulWidget {
  const MoodLoggingScreen({super.key});

  @override
  _MoodLoggingScreenState createState() => _MoodLoggingScreenState();
}

class _MoodLoggingScreenState extends State<MoodLoggingScreen> {
  final TextEditingController _notesController = TextEditingController();
  String? _selectedMood;
  double _moodIntensity = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Mood Logging'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'How are you feeling today?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: ['😊', '😢', '😠', '😰', '😌']
                  .map((mood) => ChoiceChip(
                label: Text(mood, style: TextStyle(fontSize: 24)),
                selected: _selectedMood == mood,
                onSelected: (selected) {
                  setState(() {
                    _selectedMood = selected ? mood : null;
                  });
                },
              ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'How intense is your mood?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _moodIntensity,
              min: 1,
              max: 10,
              divisions: 9,
              label: _moodIntensity.round().toString(),
              onChanged: (value) {
                setState(() {
                  _moodIntensity = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Notes (optional):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _notesController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Add any additional notes here...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveMoodEntry,
              child: const Text('Save Entry'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveMoodEntry() {
    if (_selectedMood != null) {
      final moodEntry = {
        'mood': _selectedMood,
        'intensity': _moodIntensity,
        'notes': _notesController.text,
        'timestamp': DateTime.now(),
      };
      // Save the mood entry to the database or local storage
      // For now, we'll just show a confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Mood Entry Saved'),
          content: Text(
              'Mood: $_selectedMood\nIntensity: $_moodIntensity\nNotes: ${_notesController.text}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Show an error message if no mood is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a mood before saving.'),
        ),
      );
    }
  }
}

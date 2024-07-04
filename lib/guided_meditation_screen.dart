import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/source.dart';

class GuidedMeditationScreen extends StatelessWidget {
  const GuidedMeditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guided Meditation'),
      ),
      body: ListView(
        children: [
          _buildMeditationCard(
            context,
            'Mindfulness Meditation',
            'A guided meditation to help you stay mindful and present.',
            'assets/images/mindfulness.png',
            10,
            'https://example.com/mindfulness.mp3', // Example audio URL
          ),
          _buildMeditationCard(
            context,
            'Stress Relief Meditation',
            'A guided meditation to help you relieve stress.',
            'assets/images/stress_relief.png',
            15,
            'https://example.com/stress_relief.mp3', // Example audio URL
          ),
          _buildMeditationCard(
            context,
            'Sleep Meditation',
            'A guided meditation to help you fall asleep.',
            'assets/images/sleep.png',
            20,
            'https://example.com/sleep.mp3', // Example audio URL
          ),
        ],
      ),
    );
  }

  Widget _buildMeditationCard(BuildContext context, String title, String description, String imagePath, int duration, String audioUrl) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(title),
        subtitle: Text(description),
        trailing: Text('$duration min'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MeditationPlayerScreen(
                title: title,
                duration: duration,
                audioUrl: audioUrl,
              ),
            ),
          );
        },
      ),
    );
  }
}

class MeditationPlayerScreen extends StatefulWidget {
  final String title;
  final int duration;
  final String audioUrl;

  const MeditationPlayerScreen({super.key, required this.title, required this.duration, required this.audioUrl});

  @override
  _MeditationPlayerScreenState createState() => _MeditationPlayerScreenState();
}

class _MeditationPlayerScreenState extends State<MeditationPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.self_improvement, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              'Playing ${widget.title}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Duration: ${widget.duration} minutes',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _audioPlayer.play(UrlSource(widget.audioUrl));
              },
              child: const Text('Play'),
            ),
            ElevatedButton(
              onPressed: () {
                _audioPlayer.pause();
              },
              child: const Text('Pause'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'video_call_screen.dart';

class AccessTherapistsScreen extends StatelessWidget {
  const AccessTherapistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Access Therapists'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TherapistCard(
            name: 'Dr. Wanyonyi',
            specialty: 'Clinical Psychologist',
            onChatPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(therapistName: 'Dr. peter kings'),
                ),
              );
            },
            onVideoPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoCallScreen(therapistName: 'Dr. Nicholas kimeu'),
                ),
              );
            },
          ),
          TherapistCard(
            name: 'Dr. Ephy',
            specialty: 'Counseling Psychologist',
            onChatPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(therapistName: 'Dr. Tony Wanjiru'),
                ),
              );
            },
            onVideoPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoCallScreen(therapistName: 'Dr. Peter Wanyonyi'),
                ),
              );
            },
          ),
          // Add more TherapistCard widgets as needed
        ],
      ),
    );
  }
}

class TherapistCard extends StatelessWidget {
  final String name;
  final String specialty;
  final VoidCallback onChatPressed;
  final VoidCallback onVideoPressed;

  const TherapistCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.onChatPressed,
    required this.onVideoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              specialty,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.chat),
                  label: const Text('Chat'),
                  onPressed: onChatPressed,
                ),
                const SizedBox(width: 10),
                TextButton.icon(
                  icon: const Icon(Icons.video_call),
                  label: const Text('Video Call'),
                  onPressed: onVideoPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class WellnessTrackingScreen extends StatelessWidget {
  final String userId;

  const WellnessTrackingScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness Tracking'),
      ),
      body: Center(
        child: Text('Tracking wellness for user: $userId'),
      ),
    );
  }
}

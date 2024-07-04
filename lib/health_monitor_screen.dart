import 'package:flutter/material.dart';

class HealthMonitorScreen extends StatelessWidget {
  final String userId;

  const HealthMonitorScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Monitoring'),
      ),
      body: Center(
        child: Text('Monitoring health for user: $userId'),
      ),
    );
  }
}

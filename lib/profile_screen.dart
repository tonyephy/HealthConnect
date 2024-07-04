import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;

  const ProfileScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Text('Profile of user: $userId'),
      ),
    );
  }
}

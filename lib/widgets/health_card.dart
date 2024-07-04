import 'package:flutter/material.dart';

class HealthCard extends StatelessWidget {
  final String title;
  final String value;

  const HealthCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Connect'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(
                      title: const Text('User Profile'),
                    ),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      })
                    ],
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset('assets/images/logo.png', height: 100),
                    const SizedBox(height: 20),
                    Text(
                      'Welcome!',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    _buildFeatureButton(
                      context,
                      'Daily Mood Logging',
                      Icons.sentiment_satisfied,
                      '/moodLogging',
                    ),
                    _buildFeatureButton(
                      context,
                      'Guided Meditation',
                      Icons.self_improvement,
                      '/guidedMeditation',
                    ),
                    _buildFeatureButton(
                      context,
                      'Access Therapists',
                      Icons.video_call,
                      '/accessTherapists',
                    ),
                    _buildFeatureButton(
                      context,
                      'Appointment Booking', // New feature button
                      Icons.calendar_today,
                      '/appointmentBooking',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Set the button color to red
                textStyle: const TextStyle(fontSize: 18),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Sign Out'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureButton(
      BuildContext context, String title, IconData icon, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          textStyle: const TextStyle(fontSize: 18),
        ),
        icon: Icon(icon, size: 24),
        label: Text(title),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}

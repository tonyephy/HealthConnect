import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'auth_gate.dart';
import 'splash_screen.dart';
import 'onboarding_screen.dart';
import 'welcome_screen.dart';
import 'daily_mood_logging_screen.dart';
import 'guided_meditation_screen.dart';
import 'access_therapists_screen.dart';
import 'chat_screen.dart';
import 'video_call_screen.dart';
import 'appointment_booking_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/source.dart'; // Import Source type

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp(userId: '',));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required String userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health_Connect_new',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(userId: ''), // Default or empty userId
        '/onboarding': (context) => const OnboardingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const AuthGate(),
        '/moodLogging': (context) => const MoodLoggingScreen(),
        '/guidedMeditation': (context) => const GuidedMeditationScreen(),
        '/accessTherapists': (context) => const AccessTherapistsScreen(),
        '/chat': (context) => ChatScreen(
          therapistName: ModalRoute.of(context)?.settings.arguments as String? ?? '',
        ),
        '/videoCall': (context) => VideoCallScreen(
          therapistName: ModalRoute.of(context)?.settings.arguments as String? ?? '',
        ),
        '/appointmentBooking': (context) => AppointmentBookingScreen(),
      },
    );
  }
}

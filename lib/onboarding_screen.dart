import 'package:flutter/material.dart';
import 'welcome_screen.dart';  // Import the WelcomeScreen

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              OnboardingPage(
                image: 'assets/images/onboarding1.png',
                title: 'Welcome to Health Connect',
                description: 'Your all-in-one health management app.',
                imageHeight: screenHeight * 0.5,
              ),
              OnboardingPage(
                image: 'assets/images/onboarding2.png',
                title: 'Track Your Health',
                description: 'Monitor your health stats and stay informed.',
                imageHeight: screenHeight * 0.5,
              ),
              OnboardingPage(
                image: 'assets/images/onboarding3.png',
                title: 'Get Insights',
                description: 'Receive personalized health insights.',
                imageHeight: screenHeight * 0.5,
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    _pageController.jumpToPage(2);
                  },
                  child: const Text('SKIP'),
                ),
                Row(
                  children: List<Widget>.generate(3, (int index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 10,
                      width: (index == _currentPage) ? 20 : 10,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: (index == _currentPage) ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    );
                  }),
                ),
                TextButton(
                  onPressed: () {
                    if (_currentPage == 2) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                      );
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    _currentPage == 2 ? 'DONE' : 'NEXT',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final double imageHeight;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FractionallySizedBox(
          widthFactor: 1.0,
          child: SizedBox(
            height: imageHeight,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 20.0),
        Text(
          title,
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}

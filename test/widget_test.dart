
import 'package:flutter_test/flutter_test.dart';
import 'package:health_connect/main.dart';
import 'package:health_connect/splash_screen.dart';
import 'package:health_connect/home_screen.dart';

void main() {
  testWidgets('SplashScreen shows for 8 seconds and then navigates to HomeScreen', (WidgetTester tester) async {
    // Build the app and trigger a frame
    await tester.pumpWidget(const MyApp(userId: '12345',));

    // Verify that SplashScreen is displayed
    expect(find.text('We Care'), findsOneWidget);
    expect(find.byType(SplashScreen), findsOneWidget);

    // Fast forward time by 8 seconds
    await tester.pump(const Duration(seconds: 8));

    // Trigger a frame after the duration
    await tester.pumpAndSettle();

    // Verify that HomeScreen is displayed
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Health Connect'), findsOneWidget);
  });
}

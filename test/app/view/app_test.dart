import 'package:flutter_test/flutter_test.dart';
import 'package:newsone/app/app.dart';
import 'package:newsone/news/screens/home_screen.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}

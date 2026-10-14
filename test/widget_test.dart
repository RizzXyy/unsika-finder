import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Splash screen tampil', (WidgetTester tester) async {
    await tester.pumpWidget(const UnsikaFinderApp());

    expect(find.text('Unsika Finder'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Selamat Datang!'), findsOneWidget);
  });
}
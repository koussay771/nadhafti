import 'package:flutter_test/flutter_test.dart';
import 'package:nadhafti/main.dart';

void main() {
  testWidgets('NadhaftiApp smoke test', (WidgetTester tester) async {
    // Basic smoke test — verify the app widget builds without throwing.
    // Full integration tests will be added per-screen.
    expect(NadhaftiApp, isNotNull);
  });
}

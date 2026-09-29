import 'package:flutter_test/flutter_test.dart';
import 'package:pretest_posttest_app/main.dart';

void main() {
  testWidgets('App starts and shows LoginPage', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // Verifikasi header Login dan tombol Masuk tampil di LoginPage
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);
  });
}

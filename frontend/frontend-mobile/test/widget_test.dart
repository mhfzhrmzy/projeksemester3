import 'package:flutter_test/flutter_test.dart';
import 'package:pretest_posttest_app/main.dart';

void main() {
  testWidgets('App starts and shows AuthView', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // Verifikasi tombol Login tampil di halaman Auth
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Registrasi'), findsOneWidget);
    expect(find.text('Mulai Pre-Test'), findsOneWidget);
    expect(find.text('Mulai Post-Test'), findsOneWidget);
  });
}

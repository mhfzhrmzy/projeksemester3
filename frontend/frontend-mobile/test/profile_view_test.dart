import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pretest_posttest_app/views/profile/profile_view.dart';

void main() {
  testWidgets('ProfileView renders header, menu, and logout button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: ProfileView()),
    );

    expect(find.text('Seto Son Horeg'), findsOneWidget);
    expect(find.text('Kelas 10 TKJ - SMKN 2 Jember'), findsOneWidget);
    expect(find.text('S'), findsOneWidget);
    expect(find.text('Pengaturan akun siswa'), findsOneWidget);
    expect(find.text('Sertifikat & Portofolio'), findsOneWidget);
    expect(find.text('Keluar Akun'), findsOneWidget);

    // Tap menu placeholder -> SnackBar muncul
    await tester.tap(find.text('Pengaturan akun siswa'));
    await tester.pump();
    expect(find.textContaining('coming soon'), findsOneWidget);
  });
}
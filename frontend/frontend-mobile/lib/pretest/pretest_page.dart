import 'package:flutter/material.dart';
import '../common/screens/test_page.dart';
import 'pretest_data.dart';

/// Pre-Test screen: the shared [TestPage] engine loaded with
/// Pre-Test specific questions and title.
class PretestPage extends StatelessWidget {
  const PretestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TestPage(
      title: 'Pre-Test Dasar Python',
      questions: preTestQuestions,
    );
  }
}

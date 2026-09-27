import 'package:flutter/material.dart';
import '../common/screens/test_page.dart';
import 'posttest_data.dart';

/// Post-Test screen: the shared [TestPage] engine loaded with
/// Post-Test specific questions and title.
class PosttestPage extends StatelessWidget {
  const PosttestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TestPage(
      title: 'Post-Test Dasar Python',
      questions: postTestQuestions,
    );
  }
}

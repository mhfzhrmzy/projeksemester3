import 'package:flutter/material.dart';
import '../models/question.dart';
import '../theme/app_colors.dart';
import '../widgets/answer_option.dart';
import '../widgets/audio_timer_row.dart';
import '../widgets/question_card.dart';
import '../widgets/question_navigation.dart';
import '../widgets/submit_button.dart';
import '../widgets/test_header.dart';

/// Reusable Pre-Test / Post-Test page.
///
/// Frontend only: all state (current question index and selected
/// answers) lives in memory via [StatefulWidget] + [setState]. No
/// backend, API, database or persistence is involved.
class TestPage extends StatefulWidget {
  final String title;
  final List<Question> questions;

  const TestPage({
    super.key,
    required this.title,
    required this.questions,
  });

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late int _currentIndex;
  late List<int?> _selectedAnswers;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    // One slot per question, null = not answered yet.
    _selectedAnswers = List<int?>.filled(widget.questions.length, null);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool get _allAnswered => _selectedAnswers.every((a) => a != null);

  void _selectAnswer(int optionIndex) {
    setState(() {
      _selectedAnswers[_currentIndex] = optionIndex;
    });
  }

  void _goBack() {
    if (_currentIndex == 0) return;
    setState(() {
      _currentIndex -= 1;
    });
    _scrollToTop();
  }

  void _goNext() {
    if (_currentIndex >= widget.questions.length - 1) return;
    setState(() {
      _currentIndex += 1;
    });
    _scrollToTop();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  void _onSubmit() {
    if (!_allAnswered) return;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Berhasil',
          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        content: const Text('Jawaban berhasil dikirim.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'OK',
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  static const List<String> _optionLabels = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentIndex];
    final selected = _selectedAnswers[_currentIndex];
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.shortestSide >= 600;
    // Percentage-based side margin so question/answer/nav containers
    // get generous breathing room from the screen edges (matching the
    // Figma reference spacing) on every screen size, not just a fixed
    // pixel gap.
    final double horizontalPadding = (size.width * 0.075).clamp(22.0, 40.0);
    // Constrain content width on very wide (tablet/landscape) screens
    // so the layout doesn't stretch uncomfortably wide.
    final double maxContentWidth = isTablet ? 640 : double.infinity;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        // top is handled manually inside TestHeader: the maroon box
        // is full-bleed behind the status bar (matching the design),
        // with its own internal padding pushing the title down below
        // the status bar icons — applying SafeArea(top: true) here
        // would clip that full-bleed background with a white gap.
        top: false,
        bottom: false,
        child: Column(
          children: [
            // Fixed header — never inside a scroll view.
            TestHeader(title: widget.title),
            // Scrollable question content.
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  18,
                  horizontalPadding,
                  18,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxContentWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AudioTimerRow(onPlayAudio: () {}),
                        const SizedBox(height: 14),
                        QuestionCard(
                          questionText: question.question,
                          code: question.code,
                        ),
                        const SizedBox(height: 16),
                        ...List.generate(question.options.length, (i) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: AnswerOption(
                              label: _optionLabels[i],
                              text: question.options[i],
                              isSelected: selected == i,
                              onTap: () => _selectAnswer(i),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Fixed bottom controls: nav row + submit button.
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  10,
                  horizontalPadding,
                  14,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxContentWidth),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        QuestionNavigation(
                          currentIndex: _currentIndex,
                          total: widget.questions.length,
                          onBack: _goBack,
                          onNext: _goNext,
                        ),
                        const SizedBox(height: 14),
                        SubmitButton(
                          enabled: _allAnswered,
                          onPressed: _onSubmit,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

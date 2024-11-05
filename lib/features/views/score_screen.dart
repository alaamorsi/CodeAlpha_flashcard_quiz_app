import 'package:flashcard_quiz_app/core/constants/colors.dart';
import 'package:flashcard_quiz_app/core/constants/colors.dart';
import 'package:flashcard_quiz_app/core/constants/functions.dart';
import 'package:flashcard_quiz_app/core/shared_widgets/default_app_bar.dart';
import 'package:flashcard_quiz_app/features/views/quizzes_collection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoreScreen extends StatelessWidget {
  final String score;

  const ScoreScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [mainColor, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultAppBar(
              title: 'Result',
              onPressed: () {
                navigateTo(context, const QuizzesCollectionScreen());
              },
            ),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You got : ',
                      style: TextStyle(fontSize: 32.0.sp),
                    ),
                    Text(
                      score,
                      style: TextStyle(fontSize: 32.0.sp,fontWeight: FontWeight.bold,color: mainColor),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

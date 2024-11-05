import 'package:flashcard_quiz_app/core/constants/colors.dart';
import 'package:flashcard_quiz_app/core/constants/functions.dart';
import 'package:flashcard_quiz_app/core/shared_widgets/default_app_bar.dart';
import 'package:flashcard_quiz_app/features/models/question_model.dart';
import 'package:flashcard_quiz_app/features/view_models/cubit.dart';
import 'package:flashcard_quiz_app/features/view_models/states.dart';
import 'package:flashcard_quiz_app/features/views/quizzes_collection_screen.dart';
import 'package:flashcard_quiz_app/features/views/widgets/build_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestQuestionsScreen extends StatelessWidget {
  final List<QuestionModel> list;

  const TestQuestionsScreen({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [mainColor, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Padding(
              padding: EdgeInsets.all(10.0.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DefaultAppBar(
                    title: 'Flashcard Quiz',
                    onPressed: () {
                      navigateAndFinish(
                          context, const QuizzesCollectionScreen());
                    },
                  ),
                  BuildQuestion(
                    list: list,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

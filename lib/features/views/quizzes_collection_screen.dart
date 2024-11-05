import 'package:flashcard_quiz_app/core/constants/colors.dart';
import 'package:flashcard_quiz_app/core/constants/colors.dart';
import 'package:flashcard_quiz_app/core/constants/functions.dart';
import 'package:flashcard_quiz_app/core/shared_widgets/default_app_bar.dart';
import 'package:flashcard_quiz_app/features/view_models/cubit.dart';
import 'package:flashcard_quiz_app/features/views/home_screen.dart';
import 'package:flashcard_quiz_app/features/views/test_questions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizzesCollectionScreen extends StatelessWidget {
  const QuizzesCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [mainColor,Colors.white],begin: Alignment.topCenter,end: Alignment.bottomCenter)
        ),
            child: HomeCubit.get(context).databaseList.isEmpty
                ? Center(
                child: Text(
                  'No flashcard yet!',
                  style: TextStyle(fontSize: 24.0.sp, color: Colors.black),
                ))
                : Padding(
                padding: EdgeInsets.all(10.0.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultAppBar(
                      title: 'Quizzes',
                      onPressed: () {
                        navigateAndFinish(context, const HomeScreen());
                      },
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            navigateTo(
                              context,
                              TestQuestionsScreen(
                                list: HomeCubit.get(context).databaseList[index],
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 50.0.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(width: 2.0.sp, color: mainColor),
                            ),
                            child: Text(
                              'Quiz ${index + 1}',
                              style: TextStyle(
                                fontSize: 21.0.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20.0.h),
                        itemCount: HomeCubit.get(context).databaseList.length,
                      ),
                    ),
                  ],
                ),
              ),
          ),
    );
  }
}

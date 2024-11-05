import 'package:flashcard_quiz_app/core/constants/colors.dart';
import 'package:flashcard_quiz_app/core/constants/colors.dart';
import 'package:flashcard_quiz_app/core/constants/colors.dart';
import 'package:flashcard_quiz_app/core/constants/functions.dart';
import 'package:flashcard_quiz_app/core/shared_widgets/default_app_bar.dart';
import 'package:flashcard_quiz_app/features/views/create_quiz_screen/add_question_screen.dart';
import 'package:flashcard_quiz_app/features/views/home_screen.dart';
import 'package:flashcard_quiz_app/features/views/widgets/build_next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseQuestionsNumberScreen extends StatefulWidget {
  const ChooseQuestionsNumberScreen({super.key});

  @override
  State<ChooseQuestionsNumberScreen> createState() =>
      _ChooseQuestionsNumberScreenState();
}

class _ChooseQuestionsNumberScreenState
    extends State<ChooseQuestionsNumberScreen> {
  int? selectedNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [mainColor,Colors.white],begin: Alignment.topCenter,end: Alignment.bottomCenter)
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DefaultAppBar(
                title: 'Create a Quiz',
                onPressed: () {
                  navigateAndFinish(context, const HomeScreen());
                },
              ),
              const Spacer(),
              Text(
                'Choose number of questions :',
                style: TextStyle(fontSize: 24.0.sp),
              ),
              Text(
                'Note: Number of questions between 3 : 10.',
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              SizedBox(
                height: 20.0.h,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(5.0.sp),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2.0.h, color: mainColor)),
                  child: DropdownButton<int>(
                    style: TextStyle(
                        fontSize: 16.0.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    dropdownColor: Colors.white,
                    itemHeight: 50.0,
                    alignment: AlignmentDirectional.center,
                    underline: Container(),
                    iconEnabledColor: mainColor,
                    value: selectedNumber,
                    hint: const Text(
                      "Select a number",
                      style: TextStyle(color: Colors.black),
                    ),
                    items: List.generate(
                      8,
                      (index) => DropdownMenuItem(
                        value: index + 3,
                        child: Center(child: Text((index + 3).toString())),
                      ),
                    ),
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedNumber = newValue;
                      });
                    },
                  ),
                ),
              ),
              const Spacer(),
              selectedNumber == null ? Container() :BuildNextButton(
                  nextTitle: 'Next',
                  onPressed: () {
                    navigateTo(
                        context,
                        AddQuestionScreen(
                          num: selectedNumber!.toInt(),
                        ));
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

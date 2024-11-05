import 'package:flashcard_quiz_app/core/constants/colors.dart';
import 'package:flashcard_quiz_app/core/constants/functions.dart';
import 'package:flashcard_quiz_app/features/models/question_model.dart';
import 'package:flashcard_quiz_app/features/view_models/cubit.dart';
import 'package:flashcard_quiz_app/features/views/score_screen.dart';
import 'package:flashcard_quiz_app/features/views/widgets/build_next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildQuestion extends StatefulWidget {
  final List<QuestionModel> list;

  const BuildQuestion({super.key, required this.list});

  @override
  State<BuildQuestion> createState() => _BuildQuestionState();
}

class _BuildQuestionState extends State<BuildQuestion> {
  int questionNumber = 0; // Start at index 0 for the first question
  late PageController pageController;
  late List<String> currentAnswers; // Store shuffled answers
  int score = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    currentAnswers = _shuffleAnswers(widget.list[questionNumber]);
    _resetAnswerFlags();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<String> _shuffleAnswers(QuestionModel question) {
    List<String> answers = [
      question.correctAnswer,
      ...question.wrongAnswers,
    ];
    answers.shuffle();
    return answers;
  }

  void _updateAnswers() {
    if (questionNumber < widget.list.length) {
      currentAnswers = _shuffleAnswers(widget.list[questionNumber]);
    }
  }

  void _resetAnswerFlags() {
    HomeCubit.get(context).isAnswer1 = false;
    HomeCubit.get(context).isAnswer2 = false;
    HomeCubit.get(context).isAnswer3 = false;
    HomeCubit.get(context).isInCorrect1 = false;
    HomeCubit.get(context).isInCorrect2 = false;
    HomeCubit.get(context).isInCorrect3 = false;
  }

  void checkAns(QuestionModel model, String selectedAnswer) {
    // Reset answer flags for the current question
    _resetAnswerFlags();

    // Get the correct answer and its index
    int correctIndex = currentAnswers.indexOf(model.correctAnswer);

    // Check if the selected answer is correct
    if (selectedAnswer == model.correctAnswer) {
      // Increment the score for a correct answer
      score++;

      // Mark the correct answer
      if (correctIndex != -1) {
        switch (correctIndex) {
          case 0:
            HomeCubit.get(context).isAnswer1 = true;
            break;
          case 1:
            HomeCubit.get(context).isAnswer2 = true;
            break;
          case 2:
            HomeCubit.get(context).isAnswer3 = true;
            break;
        }
      }
    } else {
      // If the answer is incorrect, mark the selected answer as incorrect
      int selectedIndex = currentAnswers.indexOf(selectedAnswer);
      if (selectedIndex != -1) {
        switch (selectedIndex) {
          case 0:
            HomeCubit.get(context).isInCorrect1 = true;
            break;
          case 1:
            HomeCubit.get(context).isInCorrect2 = true;
            break;
          case 2:
            HomeCubit.get(context).isInCorrect3 = true;
            break;
        }
      }

      // Mark the correct answer as green when an incorrect answer is selected
      if (correctIndex != -1) {
        switch (correctIndex) {
          case 0:
            HomeCubit.get(context).isAnswer1 = true; // Mark the correct answer
            break;
          case 1:
            HomeCubit.get(context).isAnswer2 = true; // Mark the correct answer
            break;
          case 2:
            HomeCubit.get(context).isAnswer3 = true; // Mark the correct answer
            break;
        }
      }
    }
  }

  Color getContainerColor(int index) {
    if (index == 0) {
      return HomeCubit.get(context).isInCorrect1
          ? Colors.red
          : HomeCubit.get(context).isAnswer1
              ? Colors.green
              : Colors.transparent;
    } else if (index == 1) {
      return HomeCubit.get(context).isInCorrect2
          ? Colors.red
          : HomeCubit.get(context).isAnswer2
              ? Colors.green
              : Colors.transparent;
    } else if (index == 2) {
      return HomeCubit.get(context).isInCorrect3
          ? Colors.red
          : HomeCubit.get(context).isAnswer3
              ? Colors.green
              : Colors.transparent;
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        itemCount: widget.list.length,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            questionNumber = index; // Update question number on page change
            _updateAnswers(); // Update answers for the new question
            _resetAnswerFlags();
          });
        },
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Question: ${index + 1}/${widget.list.length}',
                // Display current question number
                style:
                    TextStyle(fontSize: 21.0.sp, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(10.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: 0.9.sw,
                        height: 140.0.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border:
                              Border.all(width: 2.0, color: mainColor),
                        ),
                        child: Text(
                          widget.list[index].question,
                          style: TextStyle(
                              fontSize: 24.0.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0.h),
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index2) {
                        return InkWell(
                          onTap: () {
                            checkAns(
                                widget.list[index], currentAnswers[index2]);
                            setState(
                                () {}); // Refresh UI to show updated colors
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 0.9.sw,
                            height: 40.0.h,
                            decoration: BoxDecoration(
                              color: getContainerColor(index2),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                  width: 2.0, color: mainColor),
                            ),
                            child: Text(
                              currentAnswers[index2],
                              style: TextStyle(fontSize: 21.0.sp),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index2) =>
                          SizedBox(height: 20.h),
                      itemCount:
                          currentAnswers.length, // Use currentAnswers length
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100.0.h),
              (HomeCubit.get(context).isAnswer1 == false &&
                      HomeCubit.get(context).isAnswer2 == false &&
                      HomeCubit.get(context).isAnswer3 == false)
                  ? Container()
                  : index + 1 == widget.list.length
                      ? BuildNextButton(
                          nextTitle: 'Show result',
                          onPressed: () {
                            navigateTo(
                                context, ScoreScreen(score: score.toString()));
                          })
                      : BuildNextButton(
                          nextTitle: 'Next',
                          onPressed: () {
                            if (questionNumber < widget.list.length - 1) {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
            ],
          );
        },
      ),
    );
  }
}

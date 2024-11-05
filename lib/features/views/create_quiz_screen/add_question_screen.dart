import 'package:flashcard_quiz_app/core/constants/functions.dart';
import 'package:flashcard_quiz_app/core/shared_widgets/default_app_bar.dart';
import 'package:flashcard_quiz_app/features/view_models/cubit.dart';
import 'package:flashcard_quiz_app/features/view_models/states.dart';
import 'package:flashcard_quiz_app/features/views/create_quiz_screen/choose_questions_number_screen.dart';
import 'package:flashcard_quiz_app/features/views/quizzes_collection_screen.dart';
import 'package:flashcard_quiz_app/features/views/widgets/build_home_button.dart';
import 'package:flashcard_quiz_app/features/views/widgets/build_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddQuestionScreen extends StatefulWidget {
  final int num;

  const AddQuestionScreen({super.key, required this.num});

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final TextEditingController questionController = TextEditingController();

  final TextEditingController correctAnswerController = TextEditingController();

  final TextEditingController inCorrectAnswerController1 =
      TextEditingController();

  final TextEditingController inCorrectAnswerController2 =
      TextEditingController();
  var formKey = GlobalKey<FormState>();
  int questionNumber = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) async {
        if (state is SaveDataSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Quiz created successfully!',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          if (context.mounted) {
            navigateAndFinish(context, const QuizzesCollectionScreen());
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.deepPurple,Colors.white],begin: Alignment.topCenter,end: Alignment.bottomCenter)
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0.sp),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultAppBar(title: 'Create a Quiz',onPressed: (){navigateTo(context, const ChooseQuestionsNumberScreen());},),
                      Text(
                        'Enter question $questionNumber :',
                        style: TextStyle(
                            fontSize: 21.0.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0.h,
                      ),
                      BuildTextFormField(
                          hintText: 'Question',
                          textEditingController: questionController,
                          emptyError: 'Please enter the question!'),
                      SizedBox(
                        height: 30.0.h,
                      ),
                      Text(
                        'Enter the correct answer :',
                        style: TextStyle(
                            fontSize: 21.0.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0.h,
                      ),
                      BuildTextFormField(
                          hintText: 'Correct answer',
                          textEditingController: correctAnswerController,
                          emptyError: 'Please enter the correct answer!'),
                      SizedBox(
                        height: 20.0.h,
                      ),
                      Text(
                        'Enter the two incorrect answers :',
                        style: TextStyle(
                            fontSize: 21.0.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0.h,
                      ),
                      BuildTextFormField(
                          hintText: 'Incorrect answer',
                          textEditingController: inCorrectAnswerController1,
                          emptyError: 'Please enter the incorrect answer!'),
                      SizedBox(
                        height: 10.0.h,
                      ),
                      BuildTextFormField(
                          hintText: 'Incorrect answer',
                          textEditingController: inCorrectAnswerController2,
                          emptyError: 'Please enter the incorrect answer!'),
                      SizedBox(
                        height: 200.0.h,
                      ),
                      state is SaveDataLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            )
                          : BuildHomeButton(
                              buttonText:
                                  questionNumber < widget.num ? 'Next' : 'Save',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (questionNumber < widget.num) {
                                    HomeCubit.get(context).addToList(
                                        question: questionController.text,
                                        correctAnswer:
                                            correctAnswerController.text,
                                        inCorrectAnswer1:
                                            inCorrectAnswerController1.text,
                                        inCorrectAnswer2:
                                            inCorrectAnswerController2.text);
                                    setState(() {
                                      questionNumber++;
                                      questionController.clear();
                                      correctAnswerController.clear();
                                      inCorrectAnswerController1.clear();
                                      inCorrectAnswerController2.clear();
                                    });
                                  } else {
                                    HomeCubit.get(context).addToList(
                                        question: questionController.text,
                                        correctAnswer:
                                            correctAnswerController.text,
                                        inCorrectAnswer1:
                                            inCorrectAnswerController1.text,
                                        inCorrectAnswer2:
                                            inCorrectAnswerController2.text);
                                    HomeCubit.get(context).saveList();
                                    setState(() {
                                      questionController.clear();
                                      correctAnswerController.clear();
                                      inCorrectAnswerController1.clear();
                                      inCorrectAnswerController2.clear();
                                    });
                                  }
                                }
                              }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

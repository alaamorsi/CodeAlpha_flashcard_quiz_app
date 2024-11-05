import 'package:flashcard_quiz_app/core/constants/functions.dart';
import 'package:flashcard_quiz_app/features/view_models/cubit.dart';
import 'package:flashcard_quiz_app/features/views/create_quiz_screen/choose_questions_number_screen.dart';
import 'package:flashcard_quiz_app/features/views/quizzes_collection_screen.dart';
import 'package:flashcard_quiz_app/features/views/widgets/build_home_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _textController;
  late AnimationController _buttonController;
  late Animation<Offset> _textOffsetAnimation;
  late Animation<Offset> _buttonOffsetAnimation;

  @override
  void initState() {
    super.initState();
    _textController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _buttonController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _textOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _buttonOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeOut,
    ));

    _textController.forward();
    _buttonController.forward();
  }

  @override
  void dispose() {
    _textController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.deepPurple,Colors.white],begin: Alignment.topCenter,end: Alignment.bottomCenter)
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SlideTransition(
                position: _textOffsetAnimation,
                child: Text(
                  'Flashcard Quiz',
                  style: TextStyle(
                      fontSize: 34.0.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(height: 50.0.h),
              SlideTransition(
                position: _buttonOffsetAnimation,
                child: Column(
                  children: [
                    BuildHomeButton(buttonText: 'Take a Quiz', onPressed: () {
                      navigateTo(context, const QuizzesCollectionScreen());
                    }),
                    SizedBox(height: 20.0.h),
                    BuildHomeButton(
                        buttonText: 'Create a Quiz',
                        onPressed: () {
                          HomeCubit.get(context).qsList.clear();
                          navigateTo(
                              context, const ChooseQuestionsNumberScreen());
                        }),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'By Alaa Morsy',
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flashcard_quiz_app/core/services/bloc_observer.dart';
import 'package:flashcard_quiz_app/features/models/question_model.dart';
import 'package:flashcard_quiz_app/features/view_models/cubit.dart';
import 'package:flashcard_quiz_app/features/view_models/states.dart';
import 'package:flashcard_quiz_app/features/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(QuestionModelAdapter());
  }
  await Hive.openBox('myBox');
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocProvider(
          create: (BuildContext context) => HomeCubit()..getDatabaseList(),
          child: BlocConsumer<HomeCubit, HomeStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: child,
              );
            },
          ),
        );
      },
      child: const HomeScreen(),
    );
  }
}

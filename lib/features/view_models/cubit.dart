import 'package:flashcard_quiz_app/features/models/question_model.dart';
import 'package:flashcard_quiz_app/features/view_models/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeCubit extends Cubit<HomeStates> {
  late Box myBox;
  HomeCubit() : super(HomeInitialState()) {
    myBox = Hive.box('myBox');
  }

  static HomeCubit get(context) => BlocProvider.of(context);

  bool isAnswer1 = false;
  bool isAnswer2 = false;
  bool isAnswer3 = false;
  bool isInCorrect1 = false;
  bool isInCorrect2 = false;
  bool isInCorrect3 = false;
  List<String> abc = ['A. ', 'B. ', 'C. '];


//////////////////////////////////////////////////
  List<QuestionModel> qsList = [];
  late List<List<QuestionModel>> databaseList;
  void addToList({
    required String question,
    required String correctAnswer,
    required String inCorrectAnswer1,
    required String inCorrectAnswer2,
  }) {
    QuestionModel questionModel = QuestionModel(
      correctAnswer: correctAnswer,
      wrongAnswers: [inCorrectAnswer1, inCorrectAnswer2],
      question: question,
    );
    qsList.add(questionModel);
  }

  Future<void> saveList() async {
    databaseList.add(qsList);
    emit(SaveDataLoadingState());
    try {
      // Flatten `databaseList` into a single list with metadata about which inner list each item belongs to
      List<Map<String, dynamic>> flattenedList = [];
      for (int i = 0; i < databaseList.length; i++) {
        for (var question in databaseList[i]) {
          Map<String, dynamic> questionMap = question.toMap();
          questionMap['listIndex'] = i; // Tag with inner list index
          flattenedList.add(questionMap);
        }
      }

      // Save the flattened list in Hive
      await myBox.put('databaseList', flattenedList);
      emit(SaveDataSuccessState());
    } catch (error) {
      emit(SaveDataErrorState());
    }
  }




  Future<void> getDatabaseList() async {
    emit(GetDataLoadingState());
    try {
      List<dynamic>? flattenedList = myBox.get('databaseList');
      databaseList = [];
      // Convert each map back to a QuestionModel and rebuild the nested list structure
      for (var questionMap in flattenedList ?? []) {
        Map<String, dynamic> map = Map<String, dynamic>.from(questionMap);
        int listIndex = map['listIndex'];
        QuestionModel question = QuestionModel.fromJson(map);

        // Ensure databaseList has enough sub-lists
        while (databaseList.length <= listIndex) {
          databaseList.add([]);
        }
        databaseList[listIndex].add(question);
      }
      emit(GetDataSuccessState());
    } catch (error) {
      emit(GetDataErrorState());
    }
  }



}

import 'package:hive/hive.dart';

part 'question_model.g.dart'; // This will be generated automatically

@HiveType(typeId: 1) // Use a unique type ID for your model
class QuestionModel {
  @HiveField(0) // The index should match the order of fields
  late String question;

  @HiveField(1)
  late String correctAnswer;

  @HiveField(2)
  late List<String> wrongAnswers;

  QuestionModel({
    required this.question,
    required this.correctAnswer,
    required this.wrongAnswers,
  });

  // You may keep the fromJson method if you are fetching data from JSON
  QuestionModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    correctAnswer = json['correctAnswer'];
    wrongAnswers = List<String>.from(json['wrongAnswers']);
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'correctAnswer': correctAnswer,
      'wrongAnswers': wrongAnswers,
    };
  }

}

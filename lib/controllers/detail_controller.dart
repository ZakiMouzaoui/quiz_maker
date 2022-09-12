import 'package:get/get.dart';
import 'package:quiz_maker/models/question_model.dart';

import '../services/db_service.dart';

class DetailController extends GetxController{
  final _dbService = DbService();
  var questions = <QuestionModel>[];
  var loading = false;
  var notAttempted = 0;
  var randoms = [];
  var correct = 0;
  var incorrect = 0;
  var selectedOption = '';

  @override
  onInit(){
    getQuestionsByQuiz(Get.arguments["quizId"]!).then((value){
      notAttempted = questions.length;
      loading = false;
      update();
    });

    super.onInit();
  }

 Future<void> getQuestionsByQuiz(String quizId) async{
    loading = true;
    final _questions = await _dbService.getQuestionsByQuiz(quizId);
    _questions.forEach((e){
      List<String> options = [
        e.get("option1"),
        e.get("option2"),
        e.get("option3"),
        e.get("option4"),
      ];
      options.shuffle();
      questions.add(QuestionModel(
          question: e.get("question"),
          option1: options[0],
          option2: options[1],
          option3: options[2],
          option4: options[3],
          correctAnswer: e.get("option1"),
          answered: false
      ));
    });
  }

  void checkAnswer(int index, String selectedOption){
    if(!questions[index].answered){
      final questionModel = questions[index];
      questions[index] = QuestionModel(
        question: questionModel.question,
        option3: questionModel.option3,
        option1: questionModel.option1,
        option4: questionModel.option4,
        answered: true,
        correctAnswer: questionModel.correctAnswer,
        option2: questionModel.option2,
      );
      notAttempted -= 1;
      if(selectedOption != questionModel.correctAnswer){
        incorrect += 1;
      }
      else{
        correct += 1;
      }
      update();
    }
  }

  void changeSelectedOption(value){
    selectedOption = value;
    update();
  }

  void addRandom(value){
    randoms.add(value);
  }

  void reset(){
    randoms.clear();
  }
}

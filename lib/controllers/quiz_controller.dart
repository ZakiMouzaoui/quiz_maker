import 'package:get/get.dart';
import 'package:quiz_maker/models/response_model.dart';
import 'package:quiz_maker/services/db_service.dart';

class QuizController extends GetxController{
  var loading = false;
  var quizList = [];

  final _dbService = DbService();

  @override
  onInit(){
    fetchQuiz();
    super.onInit();
  }

  Future<void> addQuiz(Map<String, dynamic> quiz, String quizId)async{
    loading = true;
    update();
    await _dbService.addQuiz(quiz, quizId);
    loading = false;

    fetchQuiz();
  }

  Future<void> fetchQuiz() async{
    quizList = await _dbService.fetchQuiz();
    update();
  }

  Future<void> addQuestionToQuiz(Map<String, dynamic> question, String quizId)async{
    loading = true;
    update();
    await _dbService.addQuestionToQuiz(question, quizId).then((value) {
      loading = false;
      update();
    });

  }

  Future<bool> checkEmptyQuestion(String quizId){
    return _dbService.checkEmptyQuestion(quizId);
  }
}
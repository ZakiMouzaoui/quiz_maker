import 'package:cloud_firestore/cloud_firestore.dart';

class DbService{
  Future addQuiz(Map<String, dynamic> quiz, String id) async{
    await FirebaseFirestore.instance.collection("quiz").doc(id).set(quiz)
    .catchError((e){
    });
  }

  Future<dynamic> fetchQuiz() async{
    final quiz = await FirebaseFirestore.instance.collection("quiz").orderBy("title").get();
    return quiz.docs;
  }

  Future<void> addQuestionToQuiz(Map<String, dynamic> question, String quizId)async{
    await FirebaseFirestore.instance.collection('quiz').doc(quizId).collection("question").add(question)
        .catchError((e)=>print(e));
  }

   Future<bool> checkEmptyQuestion(String quizId)async {
    final question = await FirebaseFirestore.instance.collection("quiz").doc(quizId).collection("question").get();
    return question.size == 0;
  }

  Future<dynamic> getQuestionsByQuiz(String quizId) async{
    final questions = await FirebaseFirestore.instance.collection("quiz").doc(quizId).collection("question").get();
    return questions.docs;
  }
}
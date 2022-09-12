import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_maker/controllers/quiz_controller.dart';
import 'package:quiz_maker/pages/add_question_page.dart';
import 'package:quiz_maker/widgets/app_name_widget.dart';
import 'package:random_string/random_string.dart';

class CreateQuizPage extends StatelessWidget {
  CreateQuizPage({Key? key}) : super(key: key);

  final imgCtr = TextEditingController();
  final titleCtr = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final _quizController = Get.put(QuizController());

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppNameWidget(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 100,),
                TextFormField(
                  validator: (val) => val!.trim().isEmpty ? "Image field is required" : null,
                  controller: imgCtr,
                  decoration: InputDecoration(
                    hintText: "Quiz Image Url"
                  ),
                ),
                TextFormField(
                  validator: (val) => val!.trim().isEmpty ? "Title field is required" : null,
                  controller: titleCtr,
                  decoration: InputDecoration(
                      hintText: "Quiz Title"
                  ),
                ),
                TextFormField(
                  validator: (val) => val!.trim().isEmpty ? "Description field is required" : null,
                  controller: descriptionCtrl,
                  decoration: InputDecoration(
                      hintText: "Quiz Description"
                  ),
                ),
                SizedBox(height: 30,),
                GetBuilder<QuizController>(
                  builder: (_) => InkWell(
                    onTap: () async{
                      if(_formKey.currentState!.validate()){
                        final quizId = randomAlphaNumeric(16);
                        final quiz = {
                          "title": titleCtr.text,
                          "description": descriptionCtrl.text,
                          "imgUrl": imgCtr.text,
                          "quizId": quizId
                        };
                        await _quizController.addQuiz(quiz, quizId);
                        // Get.back();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Quiz Added",
                            ),
                            backgroundColor: Colors.black45,
                          )
                        );
                        Get.to(()=>AddQuestionPage(quizId: quizId,));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue
                      ),
                      child: Center(
                        child: _quizController.loading ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ) : Text(
                          "Create Quiz",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

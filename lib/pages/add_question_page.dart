import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_maker/pages/home_page.dart';

import '../controllers/quiz_controller.dart';
import '../widgets/app_name_widget.dart';


class AddQuestionPage extends StatelessWidget {
  AddQuestionPage({Key? key, required this.quizId}) : super(key: key);

  final questionCtrl = TextEditingController();
  final option1Ctrl = TextEditingController();
  final option2Ctrl = TextEditingController();
  final option3Ctrl = TextEditingController();
  final option4Ctrl = TextEditingController();

  final _quizController = Get.put(QuizController());

  final _formKey = GlobalKey<FormState>();

  final String quizId;

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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 100,),
                TextFormField(
                  controller: questionCtrl,
                  decoration: InputDecoration(
                      hintText: "Question"
                  ),
                  validator: (val) => val!.trim().isEmpty ? "Question field is required" : null,
                ),
                TextFormField(
                  validator: (val) => val!.trim().isEmpty ? "Option1 field is required" : null,
                  controller: option1Ctrl,
                  decoration: InputDecoration(
                      hintText: "Option1(Correct)"
                  ),
                ),
                TextFormField(
                  validator: (val) => val!.trim().isEmpty ? "Option2 field is required" : null,
                  controller: option2Ctrl,
                  decoration: InputDecoration(
                      hintText: "Option2"
                  ),
                ),
                TextFormField(
                  validator: (val) => val!.trim().isEmpty ? "Option3 field is required" : null,
                  controller: option3Ctrl,
                  decoration: InputDecoration(
                      hintText: "Option3"
                  ),
                ),
                TextFormField(
                  validator: (val) => val!.trim().isEmpty ? "Option4 field is required" : null,
                  controller: option4Ctrl,
                  decoration: InputDecoration(
                      hintText: "Option4"
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 10,
                      child: InkWell(
                        onTap: ()async{
                          final empty = await _quizController.checkEmptyQuestion(quizId);
                          if(empty){
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please add at least one question!",
                                  ),
                                  backgroundColor: Colors.black45,
                                )
                            );
                          }
                          else{
                            Get.off(()=>HomePage());
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue
                          ),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                        child: Container()
                    ),
                    Expanded(
                      flex: 10,
                      child: GetBuilder<QuizController>(
                        builder: (_) => InkWell(
                          onTap: () async{
                            if(_formKey.currentState!.validate()){
                              _quizController.addQuestionToQuiz(
                                  {
                                    "question": questionCtrl.text,
                                    "option1": option1Ctrl.text,
                                    "option2": option2Ctrl.text,
                                    "option3": option3Ctrl.text,
                                    "option4": option4Ctrl.text,
                                  }, quizId
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Question Added",
                                    ),
                                    backgroundColor: Colors.black45,
                                  )
                              );
                              questionCtrl.text = "";
                              option1Ctrl.text = "";
                              option2Ctrl.text = "";
                              option3Ctrl.text = "";
                              option4Ctrl.text = "";
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
                                "Add Question",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

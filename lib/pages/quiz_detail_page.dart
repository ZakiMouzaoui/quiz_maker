import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_maker/controllers/detail_controller.dart';
import 'package:quiz_maker/widgets/option_widget.dart';

import '../widgets/app_name_widget.dart';
import 'package:get/get.dart';


class QuizDetailPage extends StatelessWidget {
  QuizDetailPage({Key? key}) : super(key: key);

  final _detailController = Get.put(DetailController());

  final _letters = ["A", "B", "C", "D"];
  final _rand = Random();

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
      body: GetBuilder<DetailController>(
        builder: (_) => _detailController.loading
          ? Center(
          child: CircularProgressIndicator(),
        ) : Container(
          padding: EdgeInsets.all(20),
          child: Column(
              children: [
                Container(
                  height: 30,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)
                                )

                              ),
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                    _detailController.questions.length.toString(),
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20)
                                  )

                              ),
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                    "Total",
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)
                                  )

                              ),
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  _detailController.correct.toString(),
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20)
                                  )

                              ),
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  "Correct",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)
                                  )

                              ),
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  _detailController.incorrect.toString(),
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20)
                                  )

                              ),
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  "Incorrect",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)
                                  )

                              ),
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  _detailController.notAttempted.toString(),
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20)
                                  )

                              ),
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  "Not Attempted",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: Container(
                    //margin: EdgeInsets.only(bottom: 20),
                    child: ListView.builder(
                      physics: ScrollPhysics(),
                        itemCount: _detailController.questions.length,
                      itemBuilder: (_,index) {
                        _detailController.reset();
                        return Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Q${index+1}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  _detailController.questions[index].question,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Container(
                              height: 200,
                              child: ListView(
                                children: [
                                  OptionWidget(
                                      letter: "A",
                                      option: _detailController.questions[index].option1,
                                      correctAnswer: _detailController.questions[index].correctAnswer,
                                      optionSelected: '',
                                      index: index,
                                      isCorrect: _detailController.questions[index].correctAnswer == _detailController.questions[index].option1
                                  ),
                                  OptionWidget(
                                      letter: "B",
                                      option: _detailController.questions[index].option2,
                                      correctAnswer: _detailController.questions[index].correctAnswer,
                                      optionSelected: '',
                                      index: index,
                                      isCorrect: _detailController.questions[index].correctAnswer == _detailController.questions[index].option2,
                                  ),
                                  OptionWidget(
                                      letter: "C",
                                      option: _detailController.questions[index].option3,
                                      correctAnswer: _detailController.questions[index].correctAnswer,
                                      index: index,
                                      optionSelected: '',
                                      isCorrect: _detailController.questions[index].correctAnswer == _detailController.questions[index].option3
                                    ),
                                  OptionWidget(
                                      letter: "D",
                                      option: _detailController.questions[index].option4,
                                      correctAnswer: _detailController.questions[index].correctAnswer,
                                    index: index,
                                    optionSelected: '',
                                      isCorrect: _detailController.questions[index].correctAnswer == _detailController.questions[index].option4
                                  )
                                ],
                                physics: ScrollPhysics(),
                              ),
                            )
                          ],
                        );
                      }
                    ),
                  ),
                )
              ],
            ),
          ),
      ),
      
    );
  }
}

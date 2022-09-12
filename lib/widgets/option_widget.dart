import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_maker/controllers/detail_controller.dart';

class OptionWidget extends StatelessWidget {
  OptionWidget({Key? key,
    required this.letter,
    required this.option,
    required this.optionSelected,
    required this.correctAnswer,
    required this.index,
    required this.isCorrect,

  }) : super(key: key);

  final String letter;
  final String option;
  final String optionSelected;
  final String correctAnswer;
  final int index;
  final bool isCorrect;

  final _detailController = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          _detailController.checkAnswer(index, option);
          _detailController.changeSelectedOption(option);
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: _detailController.questions[index].answered
                        ? _detailController.selectedOption == option
                        ? isCorrect ? Colors.green.withOpacity(0.7) : Colors.red.withOpacity(0.8) : Colors.black45
                        : Colors.black45
                ),
                color: _detailController.questions[index].answered
                    ? _detailController.selectedOption == option
                    ? isCorrect ? Colors.green.withOpacity(0.7) : Colors.red.withOpacity(0.8) : Colors.white70
                    : Colors.white70
              ),
              child: Text(
                letter,
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 15
                ),
              ),
            ),
            SizedBox(width: 10,),
            Text(
              option,
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
    );
  }
}

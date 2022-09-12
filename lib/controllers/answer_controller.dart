import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnswerController extends GetxController {
  var backgroundColor = Colors.white70;

  void changeBackgroundColor(bool isCorrect){
    if(isCorrect){
      backgroundColor = Colors.green[700]!;
    }
    else{
      backgroundColor = Colors.red[700]!;
    }
    update();
  }
}

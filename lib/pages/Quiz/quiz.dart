import 'package:eswitching/controllers/quiz_controller.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Quiz extends GetView<QuizController> {

  final QuizController _quizController = Get.find();

  @override
  Widget build(context) {

    Widget body = Text("s");

    return SmLayout(
      title: "Quiz",
      body: body,
      back: () {
        Get.back();
      });

  }

}
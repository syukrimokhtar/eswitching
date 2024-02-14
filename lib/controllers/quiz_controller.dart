import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:eswitching/config/dio.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {

  //logging
  final _talker = Sm.instance.talker;

  var quizzes = [].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  var index = 0.obs;
  var marks = {}.obs;
  var last = false.obs;


  void start() {

    var args = Get.arguments;
    var title = args['title'];
    var quiz = args['quiz'];
    index(1);
    var q = quiz[0];
    createMark(q["answers"]);

    Get.toNamed("/quiz/question", arguments: {
      "title": title,
      "quiz": quiz
    });
  }


  void next() {

    var args = Get.arguments;
    var title = args['title'];
    var quiz = args['quiz'];
    

    var i = index.value;
    
    index(i + 1);
    var q = quiz[i - 1];
    createMark(q["answers"]);

    Get.toNamed("/quiz/question", arguments: {
      "title": title,
      "quiz": quiz
    });

  }

  void back() {

    var i = index.value;
    if(i <= 1) {
      Get.back();
      return;
    }
    index(i  - 1);
    var args = Get.arguments;
    var title = args['title'];
    var quiz = args['quiz'];
    var q = quiz[i + 1];
    createMark(q["answers"]);

    Get.toNamed("/quiz/question", arguments: {
      "title": title,
      "quiz": quiz
    });

  }

  void fetchQuiz() async {
    isLoading(true);
    error('');
    try {

      String quizUrl = "${dotenv.env['SERVE_URL']}/quiz/quiz.json";
      _talker.debug("quizUrl: $quizUrl");

      if(quizUrl.startsWith("http")) {

        var response = await dio.get(quizUrl);
        quizzes.clear();
        var body = response.data;
        if(body is String) {
          
          quizzes.addAll(jsonDecode(body));

        }else {
          
          quizzes.addAll(body);

        }
      }

      
    } on DioException catch (e) {
     if(e.type == DioExceptionType.connectionTimeout) {
      error('Fail to load JSON');
     }
     else if(e.type == DioExceptionType.receiveTimeout) {
      error('Fail to load JSON');
     }else {
      _talker.error(e);
      error('Fail to parse JSON');
     }
    }
    isLoading(false);
  }

  void createMark(answers) {

    var mark = {};
    for(var answer in answers) {
      for(var a in answer.keys) {
          mark[a] = false;
      }
    }
    marks[index.value] = mark;

  }
  
  void updateMark(String key, bool? value) {
    var mark =  marks[index.value];
    for(var m in mark.keys) {
      mark[m] = false;
    }
    mark[key] = value;
    marks[index.value] = mark;

  }

  bool getMark(key) {
    var mark =  marks[index.value];
    var value = mark[key];
    if(value == null) {
      return false;
    }
    return value;
  }

  void verify(answer) {
    var mark =  marks[index.value];
    var value = mark[answer];
    if(value) {

      //correct
      AwesomeDialog(
        context: Get.context!,
        animType: AnimType.topSlide,
        headerAnimationLoop: false,
        dismissOnTouchOutside: false,
        dialogType: DialogType.success,
        showCloseIcon: false,
        title: 'Congratulations,',
        desc: "Your answer is correct!",
        btnCancelText: "Back",
        btnCancelOnPress: () {

          Get.back();

        },
        btnOkText: "Next",
        btnOkOnPress: () {
          
          next();

        },
        btnOkIcon: Icons.check_circle,
      ).show();

    }else {

      //incorrect
      AwesomeDialog(
        context: Get.context!,
        animType: AnimType.topSlide,
        headerAnimationLoop: false,
        dismissOnTouchOutside: false,
        dialogBackgroundColor: Colors.red.shade100,
        dialogType: DialogType.error,
        showCloseIcon: false,
        title: 'Srrory,',
        desc: "Your answer is incorrect",
        btnCancelText: "Back",
        btnCancelIcon: Icons.arrow_back,
        btnCancelOnPress: () {
          
          
        },
      ).show();



    }

  }

  

}
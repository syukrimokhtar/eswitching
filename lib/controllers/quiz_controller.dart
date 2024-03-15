import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:eswitching/config/dio.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {

  //logging
  final _talker = Sm.instance.talker;

  var quizzes = [].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  var index = 0.obs;
  var last = false.obs;
  var triggered = 0.obs;
  
  List createMarks(quiz) {

    var marks = [];
    for(var question in quiz) {
      var answers = question['answers'];
      var mark = {};
      for(var answer in answers) {
        for(var key in answer.keys) {
          mark[key] = false;
        }
      }
      marks.add(mark);
    }
    return marks;

  }


  void start() {

    var args = Get.arguments;
    var title = args['title'];
    var quiz = args['quiz'];
    var marks = createMarks(quiz);
    _talker.debug(marks);

    index(0);
    triggered(0);

    Get.toNamed("/quiz/question", arguments: {
      "title": title,
      "quiz": quiz,
      "marks": marks
    });
  }


  void next() {

    var args = Get.arguments;
    var title = args['title'];
    var quiz = args['quiz'];
    var marks = args['marks'];

    var i = index.value;

    if(i == marks.length - 1) {
        //correct
        AwesomeDialog(
          context: Get.context!,
          padding: const EdgeInsets.all(10),
          animType: AnimType.topSlide,
          headerAnimationLoop: false,
          dismissOnTouchOutside: false,
          dialogType: DialogType.success,
          showCloseIcon: false,
          title: 'Congratulations,',
          desc: "Quiz completed!",
          btnCancelText: "Back",
          btnCancelOnPress: () {

            back();

          },
          btnOkText: "Home",
          btnOkOnPress: () {
            
            Get.offAllNamed("/quiz");

          },
          btnOkIcon: Icons.check_circle,
        ).show();
      return;
    }
    
    index(i + 1);
    
    Get.toNamed("/quiz/question", arguments: {
      "title": title,
      "quiz": quiz,
      "marks": marks
    });

  }

  void back() {

    var i = index.value;
    _talker.debug("i: $i");
    if(i == 0) {
      Get.back();
      return;
    }
    index(i  - 1);
    var args = Get.arguments;
    var title = args['title'];
    var quiz = args['quiz'];
    var marks = args['marks'];
    

    Get.toNamed("/quiz/question", arguments: {
      "title": title,
      "quiz": quiz,
      "marks": marks
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

  void updateMark(marks, String key, bool? value) {
    var mark =  marks[index.value];
    for(var m in mark.keys) {
      mark[m] = false;
    }
    mark[key] = value;
    marks[index.value] = mark;

    triggered(triggered.value + 1);

  }

  bool getMark(marks, key) {
    var mark =  marks[index.value];
    var value = mark[key];
    if(value == null) {
      return false;
    }
    return value;
  }

  void verify(marks, answer) {

    //verify input
    var mark =  marks[index.value];
    var empty = true;
    for(var m in mark.keys) {
      if(mark[m] == true) {
        empty = false;
      }
    }
    
    if(empty) {
      AwesomeDialog(
        context: Get.context!,
        padding: const EdgeInsets.all(10),
        animType: AnimType.topSlide,
        headerAnimationLoop: false,
        dismissOnTouchOutside: false,
        dialogBackgroundColor: Colors.red.shade100,
        dialogType: DialogType.error,
        showCloseIcon: false,
        title: 'Sorry,',
        desc: "Answer cannot empty",
        btnCancelText: "Close",
        btnCancelIcon: Icons.close,
        btnCancelOnPress: () {
          
          
        },
      ).show();
      return;
    }

    var value = mark[answer];
    if(value) {

      //correct
      AwesomeDialog(
        context: Get.context!,
        padding: const EdgeInsets.all(10),
        animType: AnimType.topSlide,
        headerAnimationLoop: false,
        dismissOnTouchOutside: false,
        dialogType: DialogType.success,
        showCloseIcon: false,
        title: 'Congratulations,',
        desc: "Your answer is correct!",
        btnCancelText: "Back",
        btnCancelOnPress: () {

          SemanticsService.announce('Back', TextDirection.ltr);
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
        padding: const EdgeInsets.all(10),
        animType: AnimType.topSlide,
        headerAnimationLoop: false,
        dismissOnTouchOutside: false,
        dialogBackgroundColor: Colors.red.shade100,
        dialogType: DialogType.error,
        showCloseIcon: false,
        title: 'Sorry,',
        desc: "Your answer is incorrect",
        btnCancelText: "Close",
        btnCancelIcon: Icons.close,
        btnCancelOnPress: () {
          
          
        },
      ).show();



    }

  }

}
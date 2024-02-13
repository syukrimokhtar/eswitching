import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eswitching/config/dio.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {

  //logging
  final _talker = Sm.instance.talker;

  var quizzes = [].obs;
  var isLoading = false.obs;
  var error = ''.obs;

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

}
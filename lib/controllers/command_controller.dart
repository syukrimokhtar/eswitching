import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:eswitching/config/dio.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class CommandController extends GetxController {

 
  //logging
  final _talker = Sm.instance.talker;

  var filePath = ''.obs;
  var pdfFile = ''.obs;
  var commands = [].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  var isShowAnswer = false.obs;
  var answerErrors = [].obs;
  final List<TextEditingController> answerControllers = [];
  
  
  
  void fetchCommand() async {
    isLoading(true);
    error('');
    try {

      String comdUrl = "${dotenv.env['SERVE_URL']}/command/command.json";
      _talker.debug("comdUrl: $comdUrl");

      if(comdUrl.startsWith("http")) {

        var response = await dio.get(comdUrl);
        commands.clear();
        var body = response.data;
        if(body is String) {

          commands.addAll(jsonDecode(body));

        }else {

          commands.addAll(body);

        }
      }

      _talker.debug(commands);

      
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

  Widget checkAnswer(TextEditingController controller, String answer) {
    
    var a1 = controller.text.trim().toLowerCase();
    var a2 = answer.trim().toLowerCase();

    if(a1 == a2) {
      return Icon(Icons.check_box, color: Sm.instance.config.successColor);
    }

    return Container();

  }

  void checkAnswers(List<String> answers) {

    int i = -1;
    bool error = false;
    for(var controller in answerControllers) {
      i++;
      var a1 = controller.text.trim().toLowerCase();
      var a2 = answers[i].trim().toLowerCase();

      if(controller.text == '') {
        answerErrors[i] = "Answer field cannot be empty";
        error = true;
      } else if(a1 != a2) {
        answerErrors[i] = "Answer incorrect";
        error = true;
      }
    }



    if(error) {
      return;
    }

      
    AwesomeDialog(
      context: Get.context!,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dismissOnTouchOutside: false,
      dialogType: DialogType.success,
      showCloseIcon: false,
      title: 'Congratulations,',
      desc: "Your answers is correct!",
      btnOkOnPress: () {
        
        Get.offAndToNamed("/command");

      },
      btnOkIcon: Icons.check_circle,
    ).show();

    

  }

  String? helper(index, String answer) {

    if(isShowAnswer.isTrue) {
      return answer;
    }
    
    if(answerErrors[index] != "") {
      return answerErrors[index];
    }

    if(answer.trim().toUpperCase() == answerControllers[index].text.trim().toUpperCase()) {
      return "Answer correct";
    }

    return null;

  }

  TextStyle? helperStyle(index, String answer) {
    
    if(isShowAnswer.isTrue) {
      return TextStyle(fontWeight: FontWeight.bold,
      color: Sm.instance.config.primaryColor);
    }

    if(answerErrors[index] != "") {
      return TextStyle(fontWeight: FontWeight.bold,
      color: Sm.instance.config.errorColor);
    }

    if(answer.trim().toUpperCase() == answerControllers[index].text.trim().toUpperCase()) {
      return TextStyle(fontWeight: FontWeight.bold,
      color: Sm.instance.config.successColor);
    }

    return null;

  }

  void clearAnswerError() {
    int i = -1;
    for (var a in answerControllers) {
      i++;
      answerErrors[i] = "";
    }
  }

}
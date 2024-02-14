import 'package:eswitching/controllers/quiz_controller.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Quiz extends GetView<QuizController> {

  //logging
  final _talker = Sm.instance.talker;

  final QuizController _quizontroller = Get.find();

  @override
  Widget build(context) {

    Widget body = Obx(() {

      if(_quizontroller.error.value.isNotEmpty) {

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: Icon(Icons.warning, color: Colors.red)),
            const SizedBox(height: 20),
            Center(child: Text(_quizontroller.error.value,
            style: const TextStyle(color: Colors.red))),
            const SizedBox(height: 50),
            GestureDetector(onTap: () {
              
              _quizontroller.fetchQuiz();

            }, child: Center(child: Text("Try Again",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Sm.instance.config.primaryColor))))
            
          ]);

      }

      else if(_quizontroller.isLoading.isTrue) {

        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: CircularProgressIndicator())
          ]);

      }else {

        return ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey.shade200,
          ),
          itemCount: _quizontroller.quizzes.length,
          itemBuilder: (context, index) {

            var quiz = _quizontroller.quizzes[index];
            
            return ListTile(
              leading: Icon(Icons.topic,
                color: Sm.instance.config.primaryColor),
              trailing: quiz['quiz'] == null ? null : Icon(Icons.arrow_forward,
                color: Sm.instance.config.primaryColor),
              title: Text(quiz['topic'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(quiz['title']),
              onTap: () {

                if(quiz['quiz'] == null) {
                  return;
                }

                Get.toNamed("/quiz/start", arguments: {
                  "title": quiz['title'],
                  "quiz": quiz['quiz']
                });
                
              },
            );
            
        });

      }

    });
    
    

    return SmLayout(
      title: "Quiz",
      body: body,
      back: () {
        Get.back();
      });

  }

}
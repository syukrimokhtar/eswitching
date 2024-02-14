import 'package:eswitching/controllers/quiz_controller.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class QuizQuestion extends GetView<QuizController> {

  //logging
  final _talker = Sm.instance.talker;
  final QuizController _quizController = Get.find();
  final ScrollController _scrollController = ScrollController();
  

  //
  // Style Html
  //
  final _style = {
    ".code": Style(
      fontSize: FontSize.small,
      color: Colors.black87
    ),
    ".text-center": Style(
      textAlign: TextAlign.center
    ),
    "table": Style(
      backgroundColor: Colors.white
    ),
    ".blue": Style(
      backgroundColor: Colors.blue.shade900,
      color: Colors.white
    ),
    "th": Style(
      padding: HtmlPaddings.only(left: 5, right: 5, top: 10, bottom: 10),
      textAlign: TextAlign.center
    ),
    "td": Style(
      padding: HtmlPaddings.only(left: 5, right: 5, top: 5, bottom: 5)
    ),
    ".compact td": Style(
      padding: HtmlPaddings.only(left: 5, right: 5, top: 1, bottom: 1)
    ),
    ".blue-blrtb-center": Style(
      backgroundColor: Colors.blue.shade900,
      color: Colors.white,
      border: Border(
      left: BorderSide(
          color: Colors.grey.shade400,
          width: 1),
      ),
    ),
    ".bl-small" : Style(
      fontSize: FontSize.small,
      border: Border(
      left: BorderSide(
          color: Colors.grey.shade400,
          width: 1),
      ),
    ),
    ".br-small" : Style(
      fontSize: FontSize.small,
      border: Border(
      right: BorderSide(
          color: Colors.grey.shade400,
          width: 1),
      ),
    ),
    ".small" : Style(
      fontSize: FontSize.small
    ),
    
    ".blb-small": Style(
      fontSize: FontSize.small,
      border: Border(
      left: BorderSide(
          color: Colors.grey.shade400,
          width: 1),
      bottom: BorderSide(
          color: Colors.grey.shade400,
          width: 1),
      )),

    ".bb-small": Style(
      fontSize: FontSize.small,
      border: Border(
      bottom: BorderSide(
          color: Colors.grey.shade400,
          width: 1),
    )),
    ".brb-small": Style(
      fontSize: FontSize.small,
      border: Border(
        bottom: BorderSide(
          color: Colors.grey.shade400,
          width: 1),
      right: BorderSide(
          color: Colors.grey.shade400,
          width: 1),
      ),
    ) 
  };

  Widget _html(question) {

    var html = "";
    if(question is String) {
      html = question;
    }else {
      html = question.join("\n");
    }

    return Html(
      data: html,
      extensions: [
      const TableHtmlExtension(),
      
      //view image
      OnImageTapExtension(onImageTap: (url, attributes, element) {
        String? imageUrl = url;

        if(imageUrl != null) {
          Get.dialog(
            Dialog(child: PhotoView(
              disableGestures: false,
              tightMode: true,
              imageProvider: NetworkImage(imageUrl))),
            );
        }
        
      })
    ],
    style: _style);

  }

  Widget _buildAnswers(answers) {
    
    List<Widget> answerList = [];
    for(var answer in answers) {
      
      for(var key in answer.keys) {
        var a = answer[key];
        a = a.join("\n");
        answerList.add(CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          dense: false,
          value: _quizController.getMark(key),
          onChanged: (value) {
            
            _quizController.updateMark(key, value);

          },
          title: _html("$a"),
        ));
      }
    }

    return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: answerList);
  }

  Widget _buildQuestion(questions) {

    int index = _quizController.index.value;
    var count = questions.length;
    var question = questions[index - 1];
    var q = "${question['question'].join()}";
    var answers = question['answers'];
    var answer = question['answer'];

    _talker.debug("answer: $answer");

    return Column(children: [
      
      // step
      Text("Question $index/$count", style: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold
      ))
      .paddingOnly(bottom: 20),

      // question
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, spreadRadius: 3),
          ]),
        child: _html(q),
      ),
      
      // anwser
      _buildAnswers(answers)
      .paddingOnly(top: 20),

      // button
      ElevatedButton.icon(onPressed: () {

            _quizController.verify(answer);

          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Sm.instance.config.primaryColor,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: const Icon(Icons.check),
          label: const Text("Submit",
            style: TextStyle(fontSize: 20)))
      .paddingOnly(top: 20),

    ]);

      //
  }

  

  @override
  Widget build(context) {

    var args = Get.arguments;
    var title = args['title'];
    var quiz = args['quiz'];

    Widget body = SingleChildScrollView(
      controller: _scrollController,
      child: Obx(() => _buildQuestion(quiz))
          .paddingOnly(top: 30, left: 15, right: 15, bottom: 100),

      );
        
    return SmLayout(
      title: title,
      body: body,
      back: () {
        _quizController.back();
      });

  }

}
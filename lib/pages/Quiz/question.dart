import 'package:eswitching/controllers/quiz_controller.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class QuizQuestion extends GetView<QuizController> {

  //logging
  final _talker = Sm.instance.talker;
  final QuizController _quizController = Get.find();
  final _formKey = GlobalKey<FormState>();
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
          contentPadding: EdgeInsets.zero,
          dense: true,
          value: false,
          onChanged: (value) {
            
          },
          title: _html("$a"),
        ));
        /*
        answerList.add(ListTile(
          titleAlignment: ListTileTitleAlignment.top,
          dense: true,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Text("$key",
              style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 20),
            Expanded(child: Text("$a"))
          ])

      )); */
      }
    }

    return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: answerList);
  }

  Widget _buildQuestions(questions) {

    List<Widget> qList = [];
    int index = -1;
    for(var el in questions) {
      index++;
      
      //question
      var q = el['question'];
      var a = el['answers'];
      qList.add(ListTile(
        titleAlignment: ListTileTitleAlignment.top,
        leading: Text("${index + 1}",
              style: const TextStyle(fontSize: 30)).paddingOnly(top: 5),
        trailing: Text(""),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _html(q),
            _buildAnswers(a)
          ]))
      );
      qList.add(Divider(color: Colors.grey.shade400));
    }
    
    return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: qList);
  }

  

  @override
  Widget build(context) {

    var args = Get.arguments;
    var title = args['title'];
    var quiz = args['quiz'];

    //var question = "${quiz['question']}";
    
    // replace {{ SERVE_URL }}
    String serveUrl = dotenv.env['SERVE_URL'] ?? '';
    //question = question.replaceAll("{{ SERVE_URL }}", serveUrl);
    
    //var answers = quiz['answers'];

    //var answer = quiz['answer'];

    Widget body = SingleChildScrollView(
      controller: _scrollController,
      child: _buildQuestions(quiz)
          .paddingOnly(top: 30, left: 15, right: 15, bottom: 100),

      );
        
    return SmLayout(
      title: title,
      body: body,
      back: () {
        Get.back();
      });

  }

}
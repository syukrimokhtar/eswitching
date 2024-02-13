import 'package:eswitching/controllers/command_controller.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:eswitching/library/sm_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class CommandTest extends GetView<CommandController> {

  //logging
  final _talker = Sm.instance.talker;
  final CommandController _commandController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  

  //
  // Style Html
  //
  final _style = {
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

  
  
  //
  // input
  //
  Widget _input(el, index, TextEditingController controller) {

  var question = "${el['q']}";
  var answer = "${el['a']}";

    return Obx(() => SmTextFormField(
      controller: controller,
      isMultiline: true,
      showClearText: true,
      maxLines: 1,
      onTap: () {
        _commandController.clearAnswerError();
        _commandController.isShowAnswer(false);
      },
      hintText: "Answer",
      helper: _commandController.helper(index, answer),
      helperStyle : _commandController.helperStyle(index, answer),
      showClearTextCallback: () {
        _commandController.answerErrors[index] = "";
      },
      title: question));
  }


  //
  // build anser
  //
  Widget _buildAnswer(answer) {

    List aList = answer;
    
    //create controller if empty
    if(_commandController.answerControllers.isEmpty) {
      
      int i = -1;
      for (var a in aList) {
        i++;
        _commandController.answerControllers.add(TextEditingController());
        _commandController.answers.add("${a['a']}");
        _commandController.answerErrors.add("");
        
      }
    }

    int index = -1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: aList.map((el) {
        index++;
        return _input(el, index, _commandController.answerControllers[index]);
      }).toList());
  }

  @override
  Widget build(context) {

    var args = Get.arguments;
    var title = args['title'];
    var test = args['test'];

    var question = "${test['question'].join("\n")}";
    // replace {{ SERVE_URL }}
    String serveUrl = dotenv.env['SERVE_URL'] ?? '';
    question = question.replaceAll("{{ SERVE_URL }}", serveUrl);

    var answer = test['answer'];

    Widget body = SingleChildScrollView(
      controller: _scrollController,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //html
            Html(
              data: question,
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
            style: _style),

            // answer
            Form(
              key: _formKey,
              child: _buildAnswer(answer)
            .paddingOnly(left: 10, right: 10, bottom: 20)),


            // button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

              ElevatedButton.icon(onPressed: () {

                if(_commandController.isShowAnswer.isTrue) {
                  _commandController.isShowAnswer(false);
                }else {
                  _commandController.isShowAnswer(true);
                }
                _commandController.clearAnswerError();

              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Sm.instance.config.secondColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.question_mark),
              label: const Text("Show Answer")),

              // button
              ElevatedButton.icon(onPressed: () {

                _commandController.isShowAnswer(false);
                _commandController.checkAnswers();

              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Sm.instance.config.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.check),
              label: const Text("Check Answer"))

            ])
            

            
          ])
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
import 'package:eswitching/controllers/notes_controller.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:get/get.dart';

class NotesNote extends GetView<NotesController> {

  //logging
  final _talker = Sm.instance.talker;
  final NotesController _notesController = Get.find();

  @override
  Widget build(context) {

    var args = Get.arguments;
    var title = args['title'];
    var subTitle = args['subTitle'];
    var note = args['note'].join("\n");

    Widget body = SingleChildScrollView(
      child: Html(
      data: note,
      extensions: const [
        TableHtmlExtension(),
      ],
      style: {
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
        "td": Style(
          padding: HtmlPaddings.all(10)
        ),
        ".bt": Style(
          border: Border(
          top: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".bb": Style(
          border: Border(
          bottom: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".bl": Style(
          border: Border(
          left: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".br": Style(
          border: Border(
          right: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".blt": Style(
          border: Border(
          left: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          top: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".brt": Style(
          border: Border(
          right: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          top: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".blb": Style(
          border: Border(
          left: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          bottom: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".brb": Style(
          border: Border(
          right: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          bottom: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".brlb": Style(
          border: Border(
          right: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          left: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          bottom: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".blt-blue": Style(
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          border: Border(
          left: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          top: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".brt-blue": Style(
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          border: Border(
          right: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          top: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        '.brlb-center': Style(
          textAlign: TextAlign.center,
          border: Border(
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            left: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            ),
        ),
        '.brb-center': Style(
          textAlign: TextAlign.center,
          border: Border(
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        '.blb-center': Style(
          textAlign: TextAlign.center,
          border: Border(
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            left: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        ".blt-blue-center": Style(
          textAlign: TextAlign.center,
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          border: Border(
            left: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        ".blrt-blue-center": Style(
          textAlign: TextAlign.center,
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          border: Border(
            left: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        ".brt-blue-center": Style(
          textAlign: TextAlign.center,
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          border: Border(
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        
      }
      
      )
    .paddingOnly(
      top: 30,
      left: 15,
      right: 15,
      bottom: 100));
    

    return SmLayout(
      title: title,
      subTitle: subTitle,
      body: body,
      back: () {
        Get.back();
      },
      actions: [
        IconButton(onPressed: () {

          _notesController.fetchNotes();
          Get.toNamed("/notes");

        }, icon: const Icon((Icons.refresh)))
      ]);

  }

}
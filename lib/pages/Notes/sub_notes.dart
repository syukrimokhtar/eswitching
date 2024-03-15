import 'package:eswitching/controllers/notes_controller.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:get/get.dart';

class NotesSubNotes extends GetView<NotesController> {

  //logging
  final _talker = Sm.instance.talker;

  @override
  Widget build(context) {

    var args = Get.arguments;
    var title = args['title'];
    var subTitle = args['subTitle'];
    var subNotes = args['subNotes'];

    Widget body = ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey.shade200,
        ),
        itemCount: subNotes.length,
        itemBuilder: (context, index) {

          var topic = subNotes[index];

          return ListTile(
            leading: Icon(Icons.topic,
              color: Sm.instance.config.primaryColor),
            trailing: Icon(Icons.arrow_forward,
              color: Sm.instance.config.primaryColor),
            title: Text(topic['title']),
            subtitle: topic['subTitle'] == null ? null : Text(topic['subTitle']),
            onTap: () {

              Get.toNamed("/notes/subNotes/note", arguments: {
                "title": topic['title'],
                "subTitle": topic['subTitle'],
                "note":  topic['note']
              });
                              
            },
          );
          
      });
    

    return SmLayout(
      title: title,
      subTitle: subTitle,
      body: body,
      back: () {
        SemanticsService.announce('Back', TextDirection.ltr);
        Get.back();
      });

  }

}
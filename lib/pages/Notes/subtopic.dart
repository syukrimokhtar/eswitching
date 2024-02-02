import 'package:eswitching/controllers/notes_controller.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubTopic extends GetView<NotesController> {

  //logging
  final _talker = Sm.instance.talker;

  @override
  Widget build(context) {

    var args = Get.arguments;
    var title = args['title'];
    var subTitle = args['subTitle'];
    var subTopic = args['subTopic'];

    Widget body = ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey.shade200,
        ),
        itemCount: subTopic.length,
        itemBuilder: (context, index) {

          var topic = subTopic[index];

          return ListTile(
            leading: Icon(Icons.topic,
              color: Sm.instance.config.primaryColor),
            trailing: Icon(Icons.arrow_forward,
              color: Sm.instance.config.primaryColor),
            title: Text(topic['title']),
            subtitle: topic['subTitle'] == null ? null : Text(topic['subTitle']),
            onTap: () {

              Get.toNamed("/notes/subtopic/note", arguments: {
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
        Get.back();
      });

  }

}
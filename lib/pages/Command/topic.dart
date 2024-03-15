import 'package:eswitching/controllers/command_controller.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:get/get.dart';

class CommandTopic extends GetView<CommandController> {

  //logging
  final _talker = Sm.instance.talker;

  final CommandController _commandController = Get.find();

  @override
  Widget build(context) {

    var args = Get.arguments;
    var title = args['title'];
    var command = args['command'];

    Widget body = ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey.shade200,
        ),
        itemCount: command.length,
        itemBuilder: (context, index) {

          var cmd = command[index];
          
          return ListTile(
            leading: Icon(Icons.topic,
              color: Sm.instance.config.primaryColor),
            trailing: Icon(Icons.arrow_forward,
              color: Sm.instance.config.primaryColor),
            title: Text(cmd['title']),
            onTap: () {

              var type = cmd['type'];
              
              if(type == "note") {

                Get.toNamed("/command/note", arguments: {
                  "title": cmd['title'],
                  "note": cmd['note']
                });

              } else if(type == "test") {

                _commandController.resetAllControllers();
                Get.toNamed("/command/test", arguments: {
                  "title": cmd['title'],
                  "test": cmd['test']
                });

              }
            },
          );
          
      });
    

    return SmLayout(
      title: title,
      body: body,
      back: () {
        SemanticsService.announce('Back', TextDirection.ltr);
        Get.back();
      });

  }

}
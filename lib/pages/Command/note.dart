import 'package:eswitching/controllers/command_controller.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class CommandNote extends GetView<CommandController> {

  //logging
  final _talker = Sm.instance.talker;

  @override
  Widget build(context) {

    var args = Get.arguments;
    var title = args['title'];
    var note = args['note'].join("\n");

    Widget body = SingleChildScrollView(
      child: Html(data: note)
    .paddingOnly(top: 30, left: 15, right: 15, bottom: 100));
    

    return SmLayout(
      title: title,
      body: body,
      back: () {
        Get.back();
      });

  }

}
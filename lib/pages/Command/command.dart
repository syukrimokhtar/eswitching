import 'package:eswitching/controllers/command_controller.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Command extends GetView<CommandController> {

  final CommandController _commandController = Get.find();

  @override
  Widget build(context) {

    Widget body = Text("s");

    return SmLayout(
      title: "Command",
      body: body,
      back: () {
        Get.back();
      });

  }

}
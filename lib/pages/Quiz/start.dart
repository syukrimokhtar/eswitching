import 'package:eswitching/controllers/quiz_controller.dart';
import 'package:eswitching/library/device_size.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizStart extends GetView<QuizController> {

  //logging
  final _talker = Sm.instance.talker;

  final QuizController _quizController = Get.find();


  Widget _start(deviceSize) {

    return SizedBox(height: deviceSize.height, width: deviceSize.width, child:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Column(children: [

          // text
          const Text("Quiz Time!",
          style: TextStyle(fontSize: 45,
            fontWeight: FontWeight.bold))
          .paddingAll(30),
          
          // button
          ElevatedButton.icon(onPressed: () {

            _quizController.start();

          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Sm.instance.config.primaryColor,
            padding: const EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: const Icon(Icons.timer),
          label: const Text("Start",
            style: TextStyle(fontSize: 20)))


        ])
        
      ],
    ));
  }

  

  @override
  Widget build(context) {

    var args = Get.arguments;
    var title = args['title'];
    
    DeviceSize deviceSize = DeviceSize.create(context);

    Widget body = _start(deviceSize);
        
    return SmLayout(
      title: title,
      body: body,
      back: () {
        Get.back();
      });

  }

}
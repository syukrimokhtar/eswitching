import 'package:eswitching/controllers/command_controller.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Command extends GetView<CommandController> {

  //logging
  final _talker = Sm.instance.talker;

  final CommandController _cmdController = Get.find();

  @override
  Widget build(context) {

    Widget body = Obx(() {

      if(_cmdController.error.value.isNotEmpty) {

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: Icon(Icons.warning, color: Colors.red)),
            const SizedBox(height: 20),
            Center(child: Text(_cmdController.error.value, 
            style: const TextStyle(color: Colors.red))),
            const SizedBox(height: 50),
            GestureDetector(onTap: () {
              
              _cmdController.fetchCommand();

            }, child: Center(child: Text("Try Again",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Sm.instance.config.primaryColor))))
            
          ]);

      }

      else if(_cmdController.isLoading.isTrue) {

        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: CircularProgressIndicator())
          ]);

      }else {

        return ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey.shade200,
          ),
          itemCount: _cmdController.commands.length,
          itemBuilder: (context, index) {

            var cmd = _cmdController.commands[index];
            
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

                }
              },
            );
            
        });

      }

    });
    
    

    return SmLayout(
      title: "Command",
      body: body,
      back: () {
        Get.back();
      });

  }

}
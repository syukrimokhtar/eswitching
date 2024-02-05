import 'package:eswitching/controllers/notes_controller.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notes extends GetView<NotesController> {

  //logging
  final _talker = Sm.instance.talker;

  final NotesController _notesController = Get.find();

  @override
  Widget build(context) {

    Widget body = Obx(() {

      if(_notesController.error.value.isNotEmpty) {

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: Icon(Icons.warning, color: Colors.red)),
            const SizedBox(height: 20),
            Center(child: Text(_notesController.error.value, 
            style: const TextStyle(color: Colors.red))),
            const SizedBox(height: 50),
            GestureDetector(onTap: () {
              
              _notesController.fetchNotes();

            }, child: Center(child: Text("Try Again",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Sm.instance.config.primaryColor))))
            
          ]);

      }

      else if(_notesController.isLoading.isTrue) {

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
          itemCount: _notesController.notes.length,
          itemBuilder: (context, index) {

            var note = _notesController.notes[index];
            
            return ListTile(
              leading: Icon(Icons.topic,
                color: Sm.instance.config.primaryColor),
              trailing: note['subNotes'] == null ? null : Icon(Icons.arrow_forward,
                color: Sm.instance.config.primaryColor),
              title: Text(note['topic'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(note['title']),
              onTap: () {

                if(note['subNotes'] == null) {
                  return;
                }

                Get.toNamed("/notes/subNotes", arguments: {
                  "title": note['title'],
                  "subTitle": note['subTitle'],
                  "subNotes": note['subNotes']
                });
                
              },
            );
            
        });

      }

    });
    
    

    return SmLayout(
      title: "Notes",
      body: body,
      back: () {
        Get.back();
      });

  }

}
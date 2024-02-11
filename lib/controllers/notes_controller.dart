import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eswitching/config/dio.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class NotesController extends GetxController {

  //logging
  final _talker = Sm.instance.talker;

  var filePath = ''.obs;
  var pdfFile = ''.obs;
  var notes = [].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  
  void fetchNotes() async {
    isLoading(true);
    error('');
    try {

      String notesUrl = "${dotenv.env['SERVE_URL']}/notes/notes.json";
      _talker.debug("notesUrl: $notesUrl");

      if(notesUrl.startsWith("http")) {

        var response = await dio.get(notesUrl);
        notes.clear();
        var body = response.data;
        if(body is String) {
          
          notes.addAll(jsonDecode(body));

        }else {
          
          notes.addAll(body);

        }
      }

      
    } on DioException catch (e) {
     if(e.type == DioExceptionType.connectionTimeout) {
      error('Fail to load JSON');
     }
     else if(e.type == DioExceptionType.receiveTimeout) {
      error('Fail to load JSON');
     }else {
      _talker.error(e);
      error('Fail to parse JSON');
     }
    }
    isLoading(false);
  }

}
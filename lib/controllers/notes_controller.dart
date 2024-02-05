import 'dart:convert';

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

      String notesUrl = dotenv.env['NOTES'] ?? '';

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

      
    }catch(e) {
      _talker.error(e);
      error('Fail to load / parse JSON');
    }
    isLoading(false);
  }

}
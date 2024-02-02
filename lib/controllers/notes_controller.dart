import 'dart:convert';
import 'dart:math';

import 'package:eswitching/library/sm_init.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
      var response = await http.get(Uri.parse("$notesUrl?rand=${Random().nextInt(1000)}"));
      notes.clear();
      notes.addAll(jsonDecode(response.body));
    }catch(e) {
      _talker.error(e);
      error('Fail to load / parse JSON');
    }
    isLoading(false);
  }

}
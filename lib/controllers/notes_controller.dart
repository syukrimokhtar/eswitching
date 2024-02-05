import 'dart:convert';

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
      var response = await http.get(Uri.parse("$notesUrl?rand=${DateTime.now().millisecondsSinceEpoch.toString()}"));
      notes.clear();
      //replace .png with rand=
      var body = response.body;
      body = body.replaceAll(".png", ".png?rand=${DateTime.now().millisecondsSinceEpoch.toString()}");
      notes.addAll(jsonDecode(response.body));
    }catch(e) {
      _talker.error(e);
      error('Fail to load / parse JSON');
    }
    isLoading(false);
  }

}
import 'dart:convert';

import 'package:eswitching/config/dio.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class CommandController extends GetxController {

 
  //logging
  final _talker = Sm.instance.talker;

  var filePath = ''.obs;
  var pdfFile = ''.obs;
  var commands = [].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  
  void fetchCommand() async {
    isLoading(true);
    error('');
    try {

      String comdUrl = dotenv.env['COMMAND'] ?? '';

      if(comdUrl.startsWith("http")) {

        var response = await dio.get(comdUrl);
        commands.clear();
        var body = response.data;
        if(body is String) {
          commands.addAll(jsonDecode(body));
        }else {
          commands.addAll(body);
        }
      }

      _talker.debug(commands);

      
    }catch(e) {
      _talker.error(e);
      error('Fail to load / parse JSON');
    }
    isLoading(false);
  }

}
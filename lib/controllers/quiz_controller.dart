import 'package:eswitching/library/sm_init.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {

  //logging
  final talker = Sm.instance.talker;

  var isLoading = false.obs;

  

  @override
  void onInit() async {
    isLoading(true);
    isLoading(false);
  }

}
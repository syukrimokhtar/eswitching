import 'package:eswitching/controllers/notes_controller.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:get/get.dart';

void smMiddlewares(Routing? routing) {

  var talker = Sm.instance.talker;

  var args = routing?.args;
  bool isBack = routing?.isBack ?? false;
  var isBlank = routing?.isBlank;
  var isBottomSheet = routing?.isBottomSheet;
  var isDialog = routing?.isDialog;
  var previous = routing?.previous;
  var current = routing?.current;

  /*
  talker.debug(
    """
    [appMiddlewares]\n
      back: $isBack,
      bottomSheet: $isBottomSheet,
      isDialog: $isDialog,
      isBlank: $isBlank,
      prev: $previous,
      current: $current,
      args: $args
    """);
*/

  if(isBack) {
    return;
  }

  //
  // Notes
  //
  if(routing!.current == '/notes') {
    Get.lazyPut<NotesController>(() => NotesController());
    NotesController notesController = Get.find<NotesController>();
    
    notesController.fetchNotes();
    
  }
}
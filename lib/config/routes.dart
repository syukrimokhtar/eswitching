import 'package:eswitching/controllers/command_controller.dart';
import 'package:eswitching/controllers/home_controller.dart';
import 'package:eswitching/controllers/notes_controller.dart';
import 'package:eswitching/controllers/quiz_controller.dart';
import 'package:eswitching/pages/Command/command.dart';
import 'package:eswitching/pages/Home/home.dart';
import 'package:eswitching/pages/Notes/note.dart';
import 'package:eswitching/pages/Notes/notes.dart';
import 'package:eswitching/pages/Notes/subtopic.dart';
import 'package:eswitching/pages/quiz/quiz.dart';
import 'package:get/get.dart';

smRoutes() => [

  //
  // Home
  //
  GetPage(
    name: '/home',
    page: () => Home(),
    binding: BindingsBuilder(() { 
      Get.lazyPut<HomeController>(() => HomeController());
      
    }),
    transition: Transition.cupertinoDialog
  ),

  //
  // Notes
  //
  GetPage(
    name: '/notes',
    page: () => Notes(),
    binding: BindingsBuilder(() { 
      Get.lazyPut<NotesController>(() => NotesController());
      
    }),
    transition: Transition.rightToLeft
  ),

  //
  // Notes / SubTopic
  //
  GetPage(
    name: '/notes/subtopic',
    page: () => SubTopic(),
    binding: BindingsBuilder(() { 
      Get.lazyPut<NotesController>(() => NotesController());
      
    }),
    transition: Transition.rightToLeft
  ),

  //
  // Notes / Note
  //
  GetPage(
    name: '/notes/subtopic/note',
    page: () => Note(),
    binding: BindingsBuilder(() { 
      Get.lazyPut<NotesController>(() => NotesController());
      
    }),
    transition: Transition.rightToLeft
  ),

  //
  // Command
  //
  GetPage(
    name: '/command',
    page: () => Command(),
    binding: BindingsBuilder(() { 
      Get.lazyPut<CommandController>(() => CommandController());
      
    }),
    transition: Transition.rightToLeft
  ),

  //
  // Quiz
  //
  GetPage(
    name: '/quiz',
    page: () => Quiz(),
    binding: BindingsBuilder(() { 
      Get.lazyPut<QuizController>(() => QuizController());
      
    }),
    transition: Transition.rightToLeft
  ),

];
import 'package:eswitching/controllers/command_controller.dart';
import 'package:eswitching/controllers/home_controller.dart';
import 'package:eswitching/controllers/notes_controller.dart';
import 'package:eswitching/controllers/quiz_controller.dart';
import 'package:eswitching/pages/Command/command.dart';
import 'package:eswitching/pages/Command/note.dart';
import 'package:eswitching/pages/Command/test.dart';
import 'package:eswitching/pages/Home/home.dart';
import 'package:eswitching/pages/Notes/note.dart';
import 'package:eswitching/pages/Notes/notes.dart';
import 'package:eswitching/pages/Notes/sub_notes.dart';
import 'package:eswitching/pages/Quiz/question.dart';
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
  // Notes / Sub Notes
  //
  GetPage(
    name: '/notes/subNotes',
    page: () => NotesSubNotes(),
    binding: BindingsBuilder(() { 
      Get.lazyPut<NotesController>(() => NotesController());
      
    }),
    transition: Transition.rightToLeft
  ),

  //
  // Notes / Note
  //
  GetPage(
    name: '/notes/subNotes/note',
    page: () => NotesNote(),
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
  // Command / Note
  //
  GetPage(
    name: '/command/note',
    page: () => CommandNote(),
    binding: BindingsBuilder(() { 
      Get.lazyPut<CommandController>(() => CommandController());
      
    }),
    transition: Transition.rightToLeft
  ),

  //
  // Command > Test
  //
  GetPage(
    name: '/command/test',
    page: () => CommandTest(),
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

  //
  // Quiz > Question
  //
  GetPage(
    name: '/quiz/question',
    page: () => QuizQuestion(),
    binding: BindingsBuilder(() { 
      Get.lazyPut<QuizController>(() => QuizController());
      
    }),
    transition: Transition.rightToLeft
  ),

];
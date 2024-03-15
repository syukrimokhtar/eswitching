import 'package:eswitching/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:get/get.dart';

class SmLayout extends GetView<HomeController> {

  late Widget body;
  late String? title;
  late String? subTitle;
  late Function? back;
  late List<Widget>? actions;
  late Widget? floatingActionButton;
  late ScrollController? scrollController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  SmLayout({
    required
    this.body,
    this.title,
    this.subTitle,
    this.back,
    this.actions,
    this.floatingActionButton,
    this.scrollController});

  Widget? _title(String? title, String? subTitle) {
    if(title == null && subTitle == null) {
      return null;
    }
    if(title != null && subTitle == null) {
      return Text(title);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      Text(title!),
      Text(subTitle!,
        style: const TextStyle(fontSize: 15))
    ]);
    
  }

  PreferredSizeWidget _appBar({
      String? title,
      String? subTitle,
    Function? back,
    List<Widget>? actions}) {
    return AppBar(
      title: _title(title, subTitle),
      leading: back == null ?
        //menu
        IconButton(onPressed: () {

          if(scaffoldKey.currentState!.isDrawerOpen){
            scaffoldKey.currentState!.closeDrawer();
          }else{
            scaffoldKey.currentState!.openDrawer();
          }

        }, icon: const Icon(Icons.menu)) :
        //back
        IconButton(onPressed: () {
          SemanticsService.announce('Back', TextDirection.ltr);
          back();
        }, icon: const Icon(Icons.arrow_back)),
      actions: actions,
      backgroundColor: Colors.transparent);
  }

  Widget _drawer() {

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero)
      ),
      child: ListView(
          children: [

            //
            // Header
            //
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade900,
                    Colors.blue.shade700
                  ],
                ),
              ),
              child: Column(children: [
                const SizedBox(height: 20),
                Image.asset("assets/images/logo.png",
                width: 60, color: Colors.white70),
                const Text("E-Switching",
                style: TextStyle(fontSize: 25, color: 
                  Colors.white70))
              ])),


            //List
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                SemanticsService.announce('Go to Home', TextDirection.ltr);
                Get.toNamed("/home");
              },
            ),

            ListTile(
              leading: const Icon(Icons.notes),
              title: const Text("Notes"),
              onTap: () {
                SemanticsService.announce('Go to Notes', TextDirection.ltr);
                Get.toNamed("/notes");
              },
            ),

            ListTile(
              leading: const Icon(Icons.abc),
              title: const Text("Command"),
              onTap: () {
                SemanticsService.announce('Go to Command', TextDirection.ltr);
                Get.toNamed("/command");
              },
            ),

            ListTile(
              leading: const Icon(Icons.question_mark),
              title: const Text("Quiz"),
              onTap: () {
                SemanticsService.announce('Go to Quiz', TextDirection.ltr);
                Get.toNamed("/quiz");
              },
            ),

          ],
        ));

  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      body: body,
      floatingActionButton: floatingActionButton,
      appBar: _appBar(
        title: title,
        subTitle: subTitle,
        back: back,
        actions: actions),
      drawer: _drawer()
    );
    
  }


}
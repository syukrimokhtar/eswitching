import 'package:eswitching/library/sm_init.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {

  const App({super.key});

  
  @override
  Widget build(BuildContext context) {
    
    return Sm.instance.createMaterialApp(context);

  }

}
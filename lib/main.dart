import 'dart:async';

import 'package:eswitching/config/app.dart';
import 'package:eswitching/config/config.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

void main() {

  runZonedGuarded(() async {

    BindingBase.debugZoneErrorsAreFatal = true;
    WidgetsFlutterBinding.ensureInitialized();
    SemanticsService.announce('Loading the App', TextDirection.ltr);

    await Sm.init(appConfig, () {

      runApp(const App());

    });

  },
  (error, stack) => Sm.handleError(error, stack));

  
}
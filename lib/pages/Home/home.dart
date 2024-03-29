import 'package:eswitching/controllers/home_controller.dart';
import 'package:eswitching/library/device_size.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends GetView<HomeController> {

  Widget _title(DeviceSize deviceSize) {
    return Column(

      children: [
        Image.asset("assets/images/logo.png",
          width: 100),
        Text(
              "e-switching",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Sm.instance.config.primaryColor)) ]

    ).paddingOnly(top: (deviceSize.height / 6) - 20);
  }
  
  Widget _policy() {
    return GestureDetector(onTap: () async {

      var serveUrl = dotenv.env['SERVE_URL'] ?? '';
      Uri url = Uri.parse("$serveUrl/PrivacyPolicy.html");
      if (!await launchUrl(url)) {
        Get.snackbar("Error", "Could not launch $url");
      }
      
      
    },child: Text(
      "Privacy Policy",
      style: TextStyle(
        fontSize: 10,
        decoration: TextDecoration.underline,
        color: Sm.instance.config.primaryColor)));
  }
  
  Widget _version() {
    return Text(
              "Version: ${dotenv.env['VERSION']} (${dotenv.env['RELEASE_DATE']})",
              style: TextStyle(
                fontSize: 10,
                color: Sm.instance.config.primaryColor));
  }
  
  Widget _button(String title, Icon icon, onPressed) {
    return OutlinedButton.icon(
      icon: icon,
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size.fromHeight(50),
        side: BorderSide(width: 2.0, color: Sm.instance.config.primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0)),
        padding: const EdgeInsets.all(15),
      ),
      label: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Sm.instance.config.primaryColor)),
    );

  }

  Widget _home() {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 90),

        _button("Notes", const Icon(Icons.notes), () {
            Get.toNamed("/notes");
          }),

        const SizedBox(height: 20),

        _button("Command", const Icon(Icons.abc), () {
            Get.toNamed("/command");
          }),

        const SizedBox(height: 20),

        _button("Quiz", const Icon(Icons.question_mark), () {
            Get.toNamed("/quiz");
          }),
      
    ])
    .paddingOnly(left: 80, right: 80);

  }

  @override
  Widget build(context) {

    DeviceSize deviceSize = DeviceSize.create(context);

    Widget body = Stack(
      children: [

        // version
        Align(
            alignment: Alignment.topCenter,
            child: _title(deviceSize)
          ),


        // home
        SizedBox(
          height: deviceSize.height,
          width: deviceSize.width,
          child: _home(),
          ),

        // version
        Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              _policy(),
              _version()
            ]).paddingOnly(bottom: 50)
          ),
      ]);

    return SmLayout(body: body);

  }

}
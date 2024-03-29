import 'package:eswitching/controllers/command_controller.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class CommandNote extends GetView<CommandController> {

  //logging
  final _talker = Sm.instance.talker;
  final CommandController _commandController = Get.find();

  @override
  Widget build(context) {

    var args = Get.arguments;
    var title = args['title'];
    var note = args['note'].join("\n");

    // replace {{ SERVE_URL }}
    if(note != null) {
      String serveUrl = dotenv.env['SERVE_URL'] ?? '';
      note = "$note".replaceAll("{{ SERVE_URL }}", serveUrl);
    }

    var style = {
        ".text-center": Style(
          textAlign: TextAlign.center
        ),
        "table": Style(
          backgroundColor: Colors.white
        ),
        ".blue": Style(
          backgroundColor: Colors.blue.shade900,
          color: Colors.white
        ),
        "th": Style(
          padding: HtmlPaddings.only(left: 5, right: 5, top: 10, bottom: 10),
          textAlign: TextAlign.center
        ),
        "td": Style(
          padding: HtmlPaddings.only(left: 5, right: 5, top: 5, bottom: 5),
        ),
        ".compact td": Style(
          padding: HtmlPaddings.only(left: 5, right: 5, top: 1, bottom: 1)
        ),
        ".blue-blrtb-center": Style(
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          border: Border(
          left: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".bl-small" : Style(
          fontSize: GetPlatform.isWindows ? FontSize.medium : FontSize.smaller,
          border: Border(
          left: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".br-small" : Style(
          fontSize: GetPlatform.isWindows ? FontSize.medium : FontSize.smaller,
          border: Border(
          right: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".small" : Style(
          fontSize: GetPlatform.isWindows ? FontSize.medium : FontSize.smaller,
        ),
        
        ".blb-small": Style(
          fontSize: GetPlatform.isWindows ? FontSize.medium : FontSize.smaller,
          border: Border(
          left: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          bottom: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          )),

        ".bb-small": Style(
          fontSize: GetPlatform.isWindows ? FontSize.medium : FontSize.smaller,
          border: Border(
          bottom: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
        )),
        ".brb-small": Style(
          fontSize: GetPlatform.isWindows ? FontSize.medium : FontSize.smaller,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          right: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        
    };

    Widget body = SingleChildScrollView(
      child: Html(
        data: note,
        extensions: [
        const TableHtmlExtension(),
        
        //view image
        OnImageTapExtension(onImageTap: (url, attributes, element) {
          String? imageUrl = url;

          if(imageUrl != null) {
            Get.dialog(
              Dialog(child: PhotoView(
                disableGestures: false,
                tightMode: true,
                imageProvider: NetworkImage(imageUrl))),
              );
          }
          
        })
      ],
      style: style)
    .paddingOnly(top: 30, left: 15, right: 15, bottom: 100));
    

    return SmLayout(
      title: title,
      body: body,
      back: () {
        SemanticsService.announce('Back', TextDirection.ltr);
        Get.back();
      });

  }

}
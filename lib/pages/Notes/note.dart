import 'package:eswitching/controllers/notes_controller.dart';
import 'package:eswitching/library/sm_init.dart';
import 'package:eswitching/library/sm_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class NotesNote extends GetView<NotesController> {

  //logging
  final _talker = Sm.instance.talker;
  final NotesController _notesController = Get.find();

  @override
  Widget build(context) {

    var args = Get.arguments;
    var title = args['title'];
    var subTitle = args['subTitle'];
    var note = args['note'].join("\n");

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
      style: {
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
        "td": Style(
          padding: HtmlPaddings.only(left: 5, right: 5, top: 10, bottom: 10)
        ),
        ".bt": Style(
          border: Border(
          top: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".bb": Style(
          border: Border(
          bottom: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".bl": Style(
          border: Border(
          left: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".br": Style(
          border: Border(
          right: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".blt": Style(
          border: Border(
          left: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          top: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".brt": Style(
          border: Border(
          right: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          top: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".brtb": Style(
          border: Border(
          right: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          top: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          bottom: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".blb": Style(
          border: Border(
          left: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          bottom: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".brb": Style(
          border: Border(
          right: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          bottom: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".brlb": Style(
          border: Border(
          right: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          left: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          bottom: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".brlt": Style(
          border: Border(
          right: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          left: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          top: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".brltb": Style(
          border: Border(
          right: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          left: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          top: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          bottom: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".blt-blue": Style(
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          border: Border(
          left: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          top: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        ".brt-blue": Style(
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          border: Border(
          right: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          top: BorderSide(
              color: Colors.grey.shade400,
              width: 1),
          ),
        ),
        '.brlb-center': Style(
          textAlign: TextAlign.center,
          border: Border(
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            left: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            ),
        ),
        '.brb-center': Style(
          textAlign: TextAlign.center,
          border: Border(
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        '.blb-center': Style(
          textAlign: TextAlign.center,
          border: Border(
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            left: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        ".blt-blue-center": Style(
          textAlign: TextAlign.center,
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          border: Border(
            left: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        ".blt-blue-small-center": Style(
          textAlign: TextAlign.center,
          fontSize: FontSize.smaller,
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          border: Border(
            left: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        ".blrt-blue-center": Style(
          textAlign: TextAlign.center,
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          border: Border(
            left: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        ".blrt-blue-small-center": Style(
          textAlign: TextAlign.center,
          fontSize: FontSize.smaller,
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          border: Border(
            left: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        ".blrtb-blue-small-center": Style(
          textAlign: TextAlign.center,
          fontSize: FontSize.smaller,
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          border: Border(
            left: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        ".brt-blue-center": Style(
          textAlign: TextAlign.center,
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          border: Border(
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        ".brt-small-center": Style(
          textAlign: TextAlign.center,
          fontSize: FontSize.smaller,
          border: Border(
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        ".brtb-small-center": Style(
          textAlign: TextAlign.center,
          fontSize: FontSize.smaller,
          border: Border(
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        ".blrt-small-center": Style(
          textAlign: TextAlign.center,
          fontSize: FontSize.smaller,
          border: Border(
            left: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
          ".blrb-small-center": Style(
          textAlign: TextAlign.center,
          fontSize: FontSize.smaller,
          border: Border(
            left: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        ".brt-blue-small-center": Style(
          textAlign: TextAlign.center,
          fontSize: FontSize.smaller,
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          border: Border(
            right: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade400,
                width: 1),
            )),
        ".code": Style(
          fontSize: FontSize.smaller
        ),
        ".code-large": Style(
          fontSize: FontSize.medium
        ),
        "ul": Style(
          margin: Margins.all(0),
          padding: HtmlPaddings.only(left: 10, top: 0,
            right: 0, bottom: 0)
        ),
        ".pl-10": Style(
          margin: Margins.only(left: 10),
          padding: HtmlPaddings.only(left: 10, top: 0,
            right: 0, bottom: 0)
        ),

        ".blue-dark-center": Style(
          backgroundColor: Colors.blue.shade900,
          color: Colors.white,
          textAlign: TextAlign.center,
          padding: HtmlPaddings.all(10)
        ),
        ".blue-light-border": Style(
          backgroundColor: Colors.blueGrey.shade100,
          color: Colors.black,
          textAlign: TextAlign.center,
          padding: HtmlPaddings.all(10),
          border: Border(
            right: BorderSide(
                color: Colors.grey.shade700,
                width: 1),
            left: BorderSide(
                color: Colors.grey.shade700,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade700,
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.shade700,
                width: 1),
            ),
        ),

        ".green-dark-center": Style(
          backgroundColor: Colors.green.shade900,
          color: Colors.white,
          textAlign: TextAlign.center,
          padding: HtmlPaddings.all(10)
        ),
        ".green-light-border": Style(
          backgroundColor: Colors.greenAccent.shade100,
          color: Colors.black,
          textAlign: TextAlign.center,
          padding: HtmlPaddings.all(10),
          border: Border(
            right: BorderSide(
                color: Colors.grey.shade700,
                width: 1),
            left: BorderSide(
                color: Colors.grey.shade700,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade700,
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.shade700,
                width: 1),
            ),
        ),

        ".orange-dark-center": Style(
          backgroundColor: Colors.deepOrange.shade900,
          color: Colors.white,
          textAlign: TextAlign.center,
          padding: HtmlPaddings.all(10)
        ),
        ".orange-light-border": Style(
          backgroundColor: Colors.orangeAccent.shade100,
          color: Colors.black,
          textAlign: TextAlign.center,
          padding: HtmlPaddings.all(10),
          border: Border(
            right: BorderSide(
                color: Colors.grey.shade700,
                width: 1),
            left: BorderSide(
                color: Colors.grey.shade700,
                width: 1),
            top: BorderSide(
                color: Colors.grey.shade700,
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.shade700,
                width: 1),
            ),
        ),

        ".blue-dark-small-center": Style(
          backgroundColor: Colors.blueGrey.shade800,
          color: Colors.white,
          fontSize: FontSize.small,
          textAlign: TextAlign.center,
          padding: HtmlPaddings.only(left: 5, right: 5, top: 10, bottom: 10),
          margin: Margins.only(left: 5, right: 5)
        ),

        ".grey-dark-small-center": Style(
          backgroundColor: Colors.grey.shade800,
          color: Colors.white,
          fontSize: FontSize.small,
          textAlign: TextAlign.center,
          padding: HtmlPaddings.only(left: 5, right: 5, top: 10, bottom: 10),
          margin: Margins.only(left: 5, right: 5)
        ),
        
      }
      
      )
    .paddingOnly(
      top: 30,
      left: 15,
      right: 15,
      bottom: 100));
    

    return SmLayout(
      title: title,
      subTitle: subTitle,
      body: body,
      back: () {
        Get.back();
      });

  }

}
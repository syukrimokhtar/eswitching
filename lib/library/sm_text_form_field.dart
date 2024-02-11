import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SmTextFormField extends StatelessWidget {
  const SmTextFormField({
    required this.controller,
    this.title,
    this.keyboardType = TextInputType.text,
    this.isRequired = false,
    this.isMultiline = false,
    this.maxLines,
    this.validator,
    this.hintText,
    this.backgroundColor = Colors.white,
    this.suffixIcon,
    this.prefixIcon,
    this.isDisable = false,
    this.onChanged,
    this.maxLength,
    this.showClearText = false,
    this.showClearTextCallback,
    this.readOnly = false,
    this.onTap,
    this.helper,
    this.helperStyle,
    super.key,
  });

  /// TextEditingController
  final TextEditingController controller;

  /// Textfield label. If-null, textfiled wont show label
  final String? title;

  /// TextInputType. If-null, this will use TextInputType.text.
  final TextInputType? keyboardType;

  /// TextLabel to show Required. Default value is false.
  final bool isRequired;

  /// TextFiled validation. Ignore if no validation check is required
  final String? Function(String? value)? validator;

  /// TextFiled hint
  final String? hintText;

  /// If true, textfiled show as text area. Default value is false.
  final bool isMultiline;

  /// Maximum line in textfiled shows. Default value is 5.
  final int? maxLines;

  /// Icon that appears at the end of textfiled
  final Widget? suffixIcon;

  /// Icon that appears at the start of textfiled
  final Widget? prefixIcon;

  /// The textfiled's background color.
  final Color? backgroundColor;

  /// If true, textLabel is disable. Default value is false.
  final bool isDisable;

  /// TextFiled onchange callback
  final void Function(String)? onChanged;

  /// maxLength, 0 mean hide
  final int? maxLength;

  /// show clear text
  final bool showClearText;
    
  /// if true, keyboard will none
  final bool readOnly;

  /// callback showClearText
  final VoidCallback? showClearTextCallback;

  /// callback onTap
  final GestureTapCallback? onTap;

  /// helper
  final String? helper;

  /// helper Style
  final TextStyle? helperStyle;


  @override
  Widget build(context) {
    Color bgColor = backgroundColor ?? Colors.white;

    
    //
    // add clear text button
    //
    Widget clearIcon = IconButton(onPressed: () {
          controller.clear();
          if(showClearTextCallback != null) {
            showClearTextCallback!();
          }
        },
        icon: const Icon(Icons.cancel).paddingOnly(right: 0));

    Widget? suffixIcons;
    if(suffixIcon != null && showClearText) {
      suffixIcons = SizedBox(width: 80, child: Row(children: [
        clearIcon,
        suffixIcon!
      ]));

    }else if(showClearText) {
      suffixIcons = clearIcon;

    }else if(suffixIcon != null) {
      suffixIcons = suffixIcon!;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // LABEL
        title != null ? _labelForm(title!, isRequired: isRequired) : const SizedBox.shrink(),

        // TEXTFORM
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          validator: validator,
          onTap: onTap,
          readOnly: readOnly,
          keyboardType: keyboardType,
          minLines: isMultiline ? null : 1,
          maxLines: maxLines ?? 5,
          cursorColor: Colors.blueGrey.shade800,
          enabled: !isDisable,
          style: TextStyle(
            color: Colors.blueGrey.shade800,
          ),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: bgColor,
            hintText: hintText?.tr,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            focusedBorder: _focusBorder,
            enabledBorder: _enabledBorder,
            disabledBorder: _disabledBorder,
            errorBorder: _errorBorder,
            focusedErrorBorder: _focusedErrorBorder,
            suffixIcon: suffixIcons,
            prefixIcon: prefixIcon,
            helperText: helper,
            helperStyle: helperStyle,
          ),
          onTapOutside: (e) => FocusManager.instance.primaryFocus?.unfocus(),
          inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
          onChanged: onChanged,
          maxLength: maxLength,
          
        ),
      ],
    );
  }
}

Widget _labelForm(String title, {bool isRequired = false}) => Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 8.0),
      child: Row(
        children: [
          Text(
            title.tr,
            style: TextStyle(
              fontSize: 13,
              color: Colors.blueGrey.shade800,
            ),
          ),
          isRequired ? _requiredText : const SizedBox.shrink(),
        ],
      ),
    );

Widget get _requiredText => Container(
    padding: const EdgeInsets.only(left: 10),
    child: Text(
      'form.required'.tr,
      style: TextStyle(
        color: Colors.red.shade200,
        fontWeight: FontWeight.bold,
      ),
    ));

InputBorder get _focusBorder => OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromARGB(100, 99, 141, 251),
        width: 1.0,
      ),
      borderRadius: _borderRadius,
    );

InputBorder get _enabledBorder => OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
      borderRadius: _borderRadius,
    );

InputBorder get _disabledBorder => OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade100, width: 1.0),
      borderRadius: _borderRadius,
    );

InputBorder get _errorBorder => OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade100, width: 1.0),
      borderRadius: _borderRadius,
    );

InputBorder get _focusedErrorBorder => OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromARGB(100, 99, 141, 251),
        width: 1.0,
      ),
      borderRadius: _borderRadius,
    );

BorderRadius get _borderRadius => const BorderRadius.all(Radius.circular(10));

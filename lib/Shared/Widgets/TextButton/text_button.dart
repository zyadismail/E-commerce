import 'package:flutter/material.dart';

import '../../Colors/colors.dart';
import '../Text/text.dart';
class BuildTextButton extends StatelessWidget {
  var text;
  var function;

  BuildTextButton({
    required this.text,
    required this.function
  });


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function,
      child: BuildText(
        text: text,
        color: AppColor.primaryColor,
        bold: true,
      ),
    );
  }
}
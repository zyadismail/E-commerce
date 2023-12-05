import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Colors/colors.dart';
class BuildText extends StatelessWidget{
  late String text;
  double? size;
  Color? color;
  bool? bold;
  bool? center;
  int? maxLines;
  bool? overflow;
  bool? lineThrow;

  BuildText({
    required this.text,
    this.color,
    this.size = 18,
    this.bold,
    this.center,
    this.maxLines,
    this.overflow,
    this.lineThrow,

  });
    @override
  Widget build (BuildContext context){
      return Text(
        text,
        overflow: overflow == null? null:TextOverflow.ellipsis,
        maxLines: maxLines == null? null: maxLines,
        style: GoogleFonts.lato(
          color: color,
          fontSize: size,
          fontWeight: bold != null ? FontWeight.bold : null,
          decoration: lineThrow == null? null :  TextDecoration.lineThrough,
        ),
        textAlign: center == null? null: TextAlign.center,
      );
    }
}





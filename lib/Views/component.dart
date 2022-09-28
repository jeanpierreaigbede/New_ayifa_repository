import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String text ;
  final double fontsize ;
  final Color color ;


  TextWidget({Key? key,required this.text,this.fontsize=15 , this.color = Colors.black}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text,
      textAlign: TextAlign.center,
      style:GoogleFonts.oswald(
      fontSize: fontsize,
      color: color,
      fontWeight: FontWeight.bold
    ) ,
    );
  }
}

class AppButton extends StatelessWidget {
  final Color color ;
  final Widget widget;
  final double height ;
   AppButton({Key? key, required this.widget,this.color = Colors.white,this.height = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8,right: 7,left: 7,bottom: 12),
      height: height,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: widget,
    );
  }
}
/*
class TextInput extends StatelessWidget {
  final String hintext ;
  final bool prefixicon ;
  final Color coloricon ;
  final TextInput
   TextInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        keyboardType: ,
      ),
    );
  }
}
*/



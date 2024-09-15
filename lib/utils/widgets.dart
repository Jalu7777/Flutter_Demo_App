import 'package:flutter/material.dart';

Widget customSizedBoxHeight({double height = 10}) => SizedBox(
      height: height,
    );

Widget customSizedBoxWidth({double width = 10}) => SizedBox(
      width: width,
    );

Widget customText(
        {required String text,
        double fsize = 14,
        FontWeight? fontWeight,
        Color fcolor = Colors.black}) =>
    Text(
      text,
      style: TextStyle(fontSize: fsize, fontWeight: fontWeight, color: fcolor),
    );

Widget customRichText(
        {required String title1,
        required String title2,
        Color t1Color = Colors.black54,
        Color t2Color = Colors.black,
        double t1Size = 15,
        double t2Size = 13,
        FontWeight? t1Weight,
        FontWeight? t2Weight,
        TextAlign? textAlign}) =>
    RichText(
        textAlign: textAlign ?? TextAlign.left,
        text: TextSpan(

            text: title1.toString().replaceAll('null', ''),
            style: TextStyle(color: t1Color, fontSize: t1Size,fontWeight: t1Weight??FontWeight.normal),
            children: [
              
              TextSpan(
                
                  style: TextStyle(color: t2Color, fontSize: t2Size,fontWeight: t2Weight??FontWeight.normal),
                  text: title2.toString().replaceAll('null', ''))
            ]));

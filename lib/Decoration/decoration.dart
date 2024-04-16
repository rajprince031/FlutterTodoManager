
import 'package:flutter/cupertino.dart';

final todo_box = BoxDecoration(
  gradient:
  SweepGradient(
    colors: [Color(0xffece9e6), Color(0xffffffff)],
    stops: [0, 1],
    center: Alignment.topRight,
  )


);

final box_deco = BoxDecoration(
  gradient:SweepGradient(
    colors: [Color(0xffe5deb6), Color(0xffecb8b8), Color(0xffc94848), Color(
        0xff544d4d)],
    stops: [0, 0.34, 0.67, 1],
    center: Alignment.topRight,
  ),

   borderRadius:BorderRadius.circular(20),
);

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


final todo_box = BoxDecoration(
  gradient:
  SweepGradient(
    colors: [Color(0xffece9e6), Color(0xffffffff)],
    stops: [0, 1],
    center: Alignment.topRight,
  )


);

final box_deco =  BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green, Colors.blue]),

   borderRadius:BorderRadius.circular(20),
);
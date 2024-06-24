import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class dashboard extends StatefulWidget{

  final token;
  const dashboard({@required this.token,Key? key}): super(key:key);
  @override
  State<dashboard> createState() => _dashboard();
}

class _dashboard extends State<dashboard>{
  late String email;

  @override
  void initState(){
    super.initState();
    Map<String,dynamic> jwtDecodeToken = JwtDecoder.decode(widget.token);
    email = jwtDecodeToken['email'];

  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar : AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children :[
            Text("Todo App"),
            Icon(Icons.account_circle,size:35)
          ]
        )
      ),
      body : Center(
        child:Column(
          mainAxisAlignment : MainAxisAlignment.center,
          children:[
            Text(email),
          ]
        )
      )
    );
  }
}














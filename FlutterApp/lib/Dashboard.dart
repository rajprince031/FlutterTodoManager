import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import './Profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';


class dashboard extends StatefulWidget {

  final token;

  const dashboard({@required this.token, Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboard();
}

class _dashboard extends State<dashboard> {
  late String userId;
  List? items;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodeToken['_id'];
    getTodo(userId);
  }

  void getTodo(userId) async {
    var regBody = {
      "userId": userId
    };
    var response = await http.post(Uri.parse(getTodoList),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody)
    );

    var jsonResponse = jsonDecode(response.body);
    items = jsonResponse['success'];
    
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Todo App"),
                InkWell(
                    child: Icon(Icons.account_circle, size: 35),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context) {
                            return ProfilePage();
                          })
                      );
                    }
                )


              ]
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Center(
            child: Text("hello")
        )
    );
  }
}














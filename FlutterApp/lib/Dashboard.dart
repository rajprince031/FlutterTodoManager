import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import './Profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './config.dart';


class dashboard extends StatefulWidget {

  final token;

  const dashboard({@required this.token, Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboard();
}

class _dashboard extends State<dashboard> {
  late String Id;

  List<dynamic> items = [];

  // Map<String, dynamic> items = {};

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(widget.token);
    Id = jwtDecodeToken['_id'];
    print("userid --------- " + Id);
    getTodo(Id);
  }

  Future<void> getTodo(String Id) async {
    try {
      var regBody = {
        "userId": Id
      };
      var response = await http.get(
        Uri.parse(getTodoList + "?userId=${Id}"),
        headers: {"Content-Type": "application/json"},
        // body: jsonEncode({"userId": Id})
      );
      print('Response status: ${response.statusCode}');
      // var jsonResponse = jsonDecode(response.body);

      // items = jsonResponse['success'];
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print("Printing the length of the items ");
        print('Parsed JSON: $jsonResponse');
        setState(() {
          items = jsonResponse['success'];
          print(items);
        });
      } else {
        print("failed to load todo");
      }
    } catch (error) {
      print("Error occur in get Todo :- $error");
    }
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
        body: Padding(

            padding: const EdgeInsets.all(8.0),
            child: items == null ? null : ListView.builder(
                itemCount: items!.length,
                itemBuilder: (context, int index) {
                  return ListTile(
                      leading: Text('${index}'),
                      title: Text("${items![index]['title']}"),
                      subtitle: Text("${items![index]['description']}")
                  );
                }
            )
        )
    );
  }
}














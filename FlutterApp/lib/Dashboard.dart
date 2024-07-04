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
  List items = [];


  @override
  void initState() {
    print('fetch the id from the login page');
    super.initState();
    Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(widget.token);
    Id = jwtDecodeToken['_id'];
    // print("userid --------- " + Id);
    getTodo(Id);
    print('init function end');
  }

//implement the get user list from the DataBase
  void getTodo(String Id) async {
    print('I am inside the getTodo function');
    try {
      // print("functon Id " + Id);
      var response = await http.get(
        Uri.parse(getTodoList + "?userId=$Id"),
      );
      print('Response status: ${response.statusCode}');
      var jsonResponse = jsonDecode(response.body);

      items = jsonResponse['success'];
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        // print("Printing the length of the items ");
        print('Parsed JSON: ${jsonResponse['status']}');
        setState(() {
          items = jsonResponse['success'];
          // print(items); //--printing the items
        });
      } else {
        print("failed to load todo");
      }
    } catch (error) {
      print("Error occur in get Todo :- $error");
    }
    print('getTodo function end');
  }

  // end the get user list function

  //upload new Todo Task dialog box
  void uploadTask(String title, String description) async {
    print('I am inside the uploadTask function');

    var regBody = {
      "userId": Id,
      "title": title,
      "description": description
    };
    var response = await http.post(Uri.parse(addTodo),
        body: jsonEncode(regBody),
        headers: {'content-type': 'application/json'}
    );
    var jsonResponse = jsonDecode(response.body);
    // print("hey I am trying to upload new todo"); //debug line
    print(jsonResponse['status']); //chceking response
    if (jsonResponse['status']) {
      setState(() {
        getTodo(Id);
      });
      Navigator.of(context).pop();
    } else {
      print("something went wrong in uploadTask Function");
    }
    print('uploadTask function end');
  }

  //function of upload new Todo Task end


// add todo dialog box function start
  void addNewTodo() {
    print('I am inside the add addNewTodo function');
    final taskController = TextEditingController();
    final descriptionController = TextEditingController();
    // bool validateTitle = false;
    // bool validateDescription = false;
    showDialog(context: context, builder: (context) {
      return AlertDialog(
          title: Text("Add New Task"),
          content: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      hintText: 'Task Title',
                    ),

                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Task Description',
                    ),
                  ),
                ]
            ),
          ), //column
          actions: [
            new ElevatedButton(
                child: Text("Add Task"),
                onPressed: () {
                  if (taskController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    uploadTask(taskController.text,
                        descriptionController.text);
                  } else {
                    print("text filed is Empty");
                  }
                }

            )
          ]
      );
    });
    print('addNewTodo function end');
  }

// add todo dialog box function end


  //delete the item from the list
  void deleteToDoItem(item) async {
    print('I am inside the deleteToDoItem function');
    print(
        'I am function I am going to print the Id :- ${item['_id']}'); //debug line
    var id = item['_id'];
    try {
      var response = await http.delete(
          Uri.parse(deleteItem + "/$id"));
      print('Response status : - ${response.statusCode}');
      if (response.statusCode == 200) {
        items.remove(item);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Item dismissed')));
        setState(() {});
      }
    } catch (e) {
      print('printing the error from the deleteToDoItem function ${e}');
    }

    print('end deleteToDoItem function');
  }

  //end delete function


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

            padding: const EdgeInsets.only(
                top: 8.0, bottom: 60, left: 8.0, right: 8.0),
            child: items == null ? null : ListView.builder(
                itemCount: items!.length,
                itemBuilder: (context, int index) {
                  final item = items[index];
                  return Card(
                      elevation: 2,
                      shadowColor: Colors.grey,
                      child: Dismissible(
                          key: Key(item['_id']),
                          onDismissed: (direction) {
                            print(
                                'I am going to print the dismissed item :- ${item}'); //debug line
                            deleteToDoItem(item);
                          },
                          background: Container(
                              color: Colors.red,
                              child: Icon(Icons.delete, color: Colors.white),
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20)
                          ),
                          child: ListTile(
                              title: Text("${items![index]['title']}"),
                              subtitle: Text("${items![index]['description']}"),
                              trailing: InkWell(
                                  child: Icon(
                                      Icons.check_circle, size: 30,
                                      color: Colors.green),
                                  onTap: () {
                                    //when click the right most check button
                                  }
                              )
                          )
                      )
                  );
                }
            )
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FractionallySizedBox(
                widthFactor: 0.9,
                heightFactor: 0.05,
                child: ElevatedButton(
                    child: Text('Add Task'),
                    onPressed: () {
                      addNewTodo();
                    }
                )
            )
        )
    );
  }


}








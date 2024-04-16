
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Decoration/decoration.dart';
import 'package:todo/task.dart';
void main() {
  runApp(Todo());
}

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'todo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoDashboard(),
    );
  }
}

class TodoDashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyTodo();
  }
}

class MyTodo extends State<TodoDashboard> {




  List<task> Task = List.empty(growable:true);
  TextEditingController enter_task = TextEditingController();
  var task_time;
  int selectedIndex = -1;

  late SharedPreferences sp;
  //
  getSharedPreferenes()async{
    sp = await SharedPreferences.getInstance();
    readFromSp();
  }

  saveIntosp(){
  List<String> taskListString =
      Task.map((Task) => jsonEncode(Task.toJson())).toList();
      sp.setStringList('myTask', taskListString);
  }

  readFromSp()
  {
    List<String>? taskListString = sp.getStringList('myTask');
    if(taskListString != null)
      {
        Task = taskListString.map((Task) => task.fromJson(json.decode(Task))).toList();
      }
    setState((){});
  }


  @override
  void initState() {
    getSharedPreferenes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Todo List')
          )
        ),
        body: Container(
          decoration: todo_box,
          child: Stack(children: [
            ListView.separated(
                itemBuilder: (context, index) {
                  return Card(
                    // block design here....
                    elevation:8,
                    shape:RoundedRectangleBorder(
                      side:BorderSide(
                        color:Colors.grey
                      ),
                      borderRadius:BorderRadius.circular(20)
                    ),
                    child: Container(
                      decoration:box_deco,
                      child: ListTile(
                        title: Text(Task[index].task_name),
                        subtitle:Text(Task[index].time),
                        trailing:InkWell(child: Icon(Icons.delete),
                        onTap:()async {
                          setState((){
                            Task.removeAt(index);
                            saveIntosp();
                          });

                      })

                      ),
                    ),
                  );
                },
                itemCount: Task.length,
                separatorBuilder: (context, index) {
                  return Divider(height: 20, thickness: 1);
                }),
            Container(
              alignment : Alignment.bottomRight,
                padding : EdgeInsets.all(14.0),
                child: FloatingActionButton(
                    child: Icon(Icons.add_box,size:35),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: Text('Add your Task'),
                                content: TextField(
                                    controller: enter_task,
                                    decoration: InputDecoration(
                                        hintText: 'Enter your Task')),
                                actions: [
                                  ElevatedButton(
                                      child: Text('Add Task'),
                                      onPressed: () async{
                                        var time = DateTime.now();
                                        String time_formate = (time.hour.toString() + ":" + time.minute.toString()
                                         +"     "+time.day.toString() +"/"+time.month.toString()+"/"
                                        +time.year.toString());
                                       String taskName = enter_task.text.trim();
                                       String TaskTime = time_formate.trim();
                                       if(taskName.isNotEmpty)
                                         {
                                             enter_task.text = '';
                                             Task.add(task(task_name : taskName ,time :TaskTime));
                                              saveIntosp();
                                         }

                                       Navigator.of(context).pop();
                                       setState((){});

                                      })
                                ]);
                          });
                    }))
          ]),
        ));
  }
}

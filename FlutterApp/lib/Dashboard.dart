// import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
//
//
// class dashboard extends StatefulWidget{
//
//   final token;
//   const dashboard({@required this.token,Key? key}): super(key:key);
//   @override
//   State<dashboard> createState() => _dashboard();
// }
//
// class _dashboard extends State<dashboard>{
//   late String email;
//
//   @override
//   void initState(){
//     super.initState();
//     Map<String,dynamic> jwtDecodeToken = JwtDecoder.decode(widget.token);
//     email = jwtDecodeToken['email'];
//
//   }
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body : Center(
//         child:Column(
//           mainAxisAlignment : MainAxisAlignment.center,
//           children:[
//             Text(email),
//           ]
//         )
//       )
//     );
//   }
// }

//-------------------------------------------------------
import 'package:flutter/material.dart';
import 'Profile.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
class Task {
  String title;
  bool isComplete;

  Task({required this.title, this.isComplete = false});
}

class dashboard extends StatefulWidget {
  final token;
  const dashboard({@required this.token,Key? key}):super(key:key);
  @override
  State<dashboard> createState() => _dashboard();
}

class _dashboard extends State<dashboard> {
  late String email;

  @override
  void initState(){
    super.initState();
    Map<String,dynamic> jwtDecodeToken = JwtDecoder.decode(widget.token);
    email = jwtDecodeToken['email'];
  }


  List<Task> _tasks = [];

  void _addTask(String title) {
    setState(() {
      _tasks.add(Task(title: title));
    });
  }

  void _removeTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  void _toggleComplete(Task task) {
    setState(() {
      task.isComplete = !task.isComplete;
    });
  }

  void _editTask(Task task, String newTitle) {
    setState(() {
      task.title = newTitle;
    });
  }

  void _addTaskDialog() {
    final taskController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Task'),
        content: TextField(
          controller: taskController,
          decoration: InputDecoration(hintText: 'Enter task title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (taskController.text.isNotEmpty) {
                _addTask(taskController.text);
                Navigator.of(context).pop();
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editTaskDialog(Task task) {
    final taskController = TextEditingController(text: task.title);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Task'),
        content: TextField(
          controller: taskController,
          decoration: InputDecoration(hintText: 'Enter new task title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (taskController.text.isNotEmpty) {
                _editTask(task, taskController.text);
                Navigator.of(context).pop();
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Tablet or Desktop Layout
            return _buildWideLayout();
          } else {
            // Mobile Layout
            return _buildNarrowLayout();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTaskDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _buildTaskList(),
        ),
        Expanded(
          flex: 1,
          child: Center(child: Text('Additional content for larger screens')),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return _buildTaskList();
  }

  Widget _buildTaskList() {
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return ListTile(
          title: Text(
            task.title,
            style: TextStyle(
                decoration: task.isComplete
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          leading: IconButton(
            icon: Icon(task.isComplete
                ? Icons.check_box
                : Icons.check_box_outline_blank),
            onPressed: () {
              _toggleComplete(task);
            },
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _editTaskDialog(task);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _removeTask(task);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}


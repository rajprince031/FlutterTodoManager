class task
{
  String task_name;
  var time;
  task( {required this.task_name,required this.time});


  factory task.fromJson(Map<String , dynamic> json) => task (
    task_name : json["task_name"],
        time : json["time"]
  );

  Map<String,dynamic> toJson() => {
    "task_name" : task_name,
    "time" : time,
  };
}
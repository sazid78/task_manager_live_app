import 'package:flutter/material.dart';
import 'package:task_manager_live_app/data.network_caller/models/task.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/widgets/task_item_card.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';


enum TaskStatus{
  New,
  Progress,
  Completed,
  Cancelled
}

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    super.key, required this.task, required this.onStatusChange, required this.showProgress,
  });

  final Task task;
  final VoidCallback onStatusChange;
  final Function(bool) showProgress;
  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {

  Future<void> UpdateTaskStatus(String Status) async{
    widget.showProgress(true);
    final response = await NetworkCaller().getRequest(Urls.UpdateTaskStatus(widget.task.sId?? '',Status));
    if(response.isSuccess){
      widget.onStatusChange();
    }
    widget.showProgress(false);
}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.task.title ?? " ",style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
              )),
              Text(widget.task.description ?? " "),
              Text("Time: ${widget.task.createdDate}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(
                      widget.task.status ?? "New",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  Wrap(
                    children: [
                      // TextButton(onPressed: (){
                      //
                      // }, child: Icon(Icons.delete,color: Colors.red,)),
                      TextButton(onPressed: (){
                        showUpdateStatusModel();
                      }, child: Icon(Icons.edit,color: Colors.green,))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void showUpdateStatusModel(){
    List<ListTile> items = TaskStatus.values.map((e) => ListTile(
      title: Text(e.name),
      onTap: (){
        UpdateTaskStatus(e.name);
        Navigator.pop(context);
      },
    )).toList();
    showDialog(context: (context), builder: (context){
      return AlertDialog(
        title: Text("Update Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: items,
        ),
        actions: [
          ButtonBar(
            children: [
              TextButton(onPressed: (){
                
              }, child: Text("Update")),
              TextButton(onPressed: (){

              }, child: Text("Cancel"),style: ButtonStyle(

              ),)
            ],
          )
        ],
      );
    });
}
}

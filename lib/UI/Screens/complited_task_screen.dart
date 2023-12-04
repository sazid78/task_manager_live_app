import 'package:flutter/material.dart';
import 'package:task_manager_live_app/data.network_caller/models/task_list_model.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_live_app/widgets/profile_summery_card.dart';
import 'package:task_manager_live_app/widgets/task_item_card.dart';

class ComplitedTaskScreen extends StatefulWidget {
  const ComplitedTaskScreen({Key? key}) : super(key: key);

  @override
  State<ComplitedTaskScreen> createState() => _ComplitedTaskScreenState();
}

class _ComplitedTaskScreenState extends State<ComplitedTaskScreen> {

  bool getComplitedTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();
  Future<void> getComplitedTaskList() async{
    getComplitedTaskInProgress = true;

    if(mounted){
      setState(() {

      });
    }
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getComplitedTask);

    if(response.isSuccess){
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getComplitedTaskInProgress = false;
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComplitedTaskList();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(
      children: [
        const ProfileSummeryCard(),
        Expanded(
          child: Visibility(
            visible: getComplitedTaskInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: RefreshIndicator(
              onRefresh: () async{
                getComplitedTaskList();
              },
              child: ListView.builder(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskItemCard(
                      task: taskListModel.taskList![index],
                      onStatusChange: (){
                        getComplitedTaskList();
                      },
                      showProgress: (inProgress){
                        if(mounted){
                          setState(() {

                          });
                        }
                      },
                    );
                  }),
            ),
          ),
        ),
      ],
    ));
  }
}

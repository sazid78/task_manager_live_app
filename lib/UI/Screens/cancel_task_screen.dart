import 'package:flutter/material.dart';
import 'package:task_manager_live_app/data.network_caller/models/task_list_model.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_live_app/widgets/profile_summery_card.dart';
import 'package:task_manager_live_app/widgets/task_item_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({Key? key}) : super(key: key);

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {

  bool getCancelledTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();
  Future<void> getCancelledTaskList() async{
    getCancelledTaskInProgress = true;

    if(mounted){
      setState(() {

      });
    }
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getCancelledTask);

    if(response.isSuccess){
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getCancelledTaskInProgress = false;
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCancelledTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(
      children: [
        const ProfileSummeryCard(),
        Expanded(
          child: Visibility(
            visible: getCancelledTaskInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: RefreshIndicator(
              onRefresh: () async{
                getCancelledTaskList();
              },
              child: ListView.builder(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskItemCard(
                      task: taskListModel.taskList![index],
                      onStatusChange: (){
                        getCancelledTaskList();
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

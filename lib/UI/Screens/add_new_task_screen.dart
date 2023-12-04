import 'package:flutter/material.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_live_app/widgets/body_background.dart';
import 'package:task_manager_live_app/widgets/profile_summery_card.dart';
import 'package:task_manager_live_app/widgets/snack_message.dart';
import 'package:task_manager_live_app/widgets/summery_card.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final TextEditingController _subjectTEcontroller = TextEditingController();
  final TextEditingController _descriptionTEcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _createTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileSummeryCard(),
            Expanded(
                child: BodyBackground(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Add New Task",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        TextFormField(
                          controller: _subjectTEcontroller,
                          decoration: InputDecoration(hintText: "Subject"),
                          validator: (String? value){
                            if(value?.trim().isEmpty ?? true){
                              return "Enter a subject";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _descriptionTEcontroller,
                          maxLines: 7,
                          decoration: InputDecoration(hintText: "Description"),
                          validator: (String? value){
                            if(value?.trim().isEmpty?? true){
                              return "Enter a Description";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: _createTaskInProgress == false,
                            replacement: Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                                onPressed: CreateNewTask,
                                child: Icon(Icons.arrow_circle_right_outlined)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> CreateNewTask() async{
    if(_formKey.currentState!.validate()){
      _createTaskInProgress = true;
      if(mounted){
        setState(() {

        });
      }
      final NetworkResponse response = await NetworkCaller().postRequest(Urls.createNewTask,body: {
        "title": _subjectTEcontroller.text.trim(),
        "description":_descriptionTEcontroller.text.trim(),
        "status":"New"
      });
      _createTaskInProgress = false;
      if(mounted){
        setState(() {

        });
      }
      if(response.isSuccess){
        _descriptionTEcontroller.clear();
        _subjectTEcontroller.clear();
        if(mounted){
          SnackMessage(context, "Task Created Successfully.");
        }
      }else{
        if(mounted){
          SnackMessage(context, "Create New Task failed, Try Again",true);
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _subjectTEcontroller.dispose();
    _descriptionTEcontroller.dispose();
    super.dispose();
  }
}

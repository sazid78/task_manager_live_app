import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_live_app/UI/controller/authentication_controller.dart';
import 'package:task_manager_live_app/data.network_caller/models/user_model.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_live_app/widgets/body_background.dart';
import 'package:task_manager_live_app/widgets/profile_summery_card.dart';
import 'package:task_manager_live_app/widgets/snack_message.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _firstNameTEcontroller = TextEditingController();
  final TextEditingController _lastNameTEcontroller = TextEditingController();
  final TextEditingController _mobileTEcontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();

  bool _updateProfileInProgress = false;
  XFile? photo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTEcontroller.text = AuthenticationController.user?.email ?? "";
    _firstNameTEcontroller.text = AuthenticationController.user?.firstName ?? "";
    _lastNameTEcontroller.text = AuthenticationController.user?.lastName ?? "";
    _mobileTEcontroller.text = AuthenticationController.user?.mobile ?? "";

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileSummeryCard(
              enableOnTap: false,
            ),
            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Update Profile",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        PhotoPicker(),
                        SizedBox(height: 8,),
                        TextFormField(
                          controller: _emailTEcontroller,
                          decoration: InputDecoration(hintText: "Email"),validator: (String? value) {
                          if (value!.isEmpty ||!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value!)) {
                            return "Enter your valied email address";
                          }
                          return null;
                        },

                        ),
                        SizedBox(height: 8,),
                        TextFormField(
                          controller: _firstNameTEcontroller,
                          decoration: InputDecoration(hintText: "First Name"),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return "Enter your first Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8,),
                        TextFormField(
                          controller: _lastNameTEcontroller,
                          decoration: InputDecoration(hintText: "Last Name"),
                          validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your last Name";
                          }
                          return null;
                        },

                        ),
                        SizedBox(height: 8,),
                        TextFormField(
                          controller: _mobileTEcontroller,
                          decoration: InputDecoration(hintText: "Mobile"),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return "Enter your Mobile Number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8,),
                        TextFormField(
                          controller: _passwordTEcontroller,
                          decoration: InputDecoration(hintText: "Password(optional)"),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return "Enter the password";
                            }
                            if (value!.length < 6) {
                              return "Your password length must have more then 6 letter";
                            }
                          },
                        ),

                        SizedBox(height: 8,),
                        SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: _updateProfileInProgress == false,
                            replacement: Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                                onPressed: () {
                                  updateProfile();
                                },
                                child: Icon(Icons.arrow_circle_right_outlined)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Future<void> updateProfile() async{

    _updateProfileInProgress = true;

    if(mounted){
      setState(() {

      });
    }
    String? photoInBase64;
    Map<String,dynamic> inputData = {

        "firstName":_firstNameTEcontroller.text.trim(),
        "lastName":_lastNameTEcontroller.text.trim(),
        "email":_emailTEcontroller.text.trim(),
        "mobile":_mobileTEcontroller.text.trim(),

    };

    if(_passwordTEcontroller.text.isNotEmpty){
      inputData["password" ] = _passwordTEcontroller.text;
    }

    if(photo != null) {
      List<int> imageBytes = await photo!.readAsBytes();
      photoInBase64 = base64Encode(imageBytes);
      inputData["photo"] = photoInBase64;
    }

    final NetworkResponse response = await NetworkCaller().postRequest(Urls.updateProfile,body: inputData);
    _updateProfileInProgress = false;
    if(mounted){
      setState(() {

      });
    }
    if(response.isSuccess){
      AuthenticationController.updateUserInformation(UserModel(
          email: _emailTEcontroller.text.trim(),
          firstName: _firstNameTEcontroller.text.trim(),
          lastName: _lastNameTEcontroller.text.trim(),
          mobile: _mobileTEcontroller.text.trim()));
      if(mounted){
        SnackMessage(context, "Update Profile Updated");
      }
    }else{
      if(mounted){
        SnackMessage(context, "Update Profile Failed! Try again",false);
      }
    }
  }

  Container PhotoPicker() {
    return Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8)
                                    )
                                  ),
                                  child: Center(
                                    child: Text("Photo",style: TextStyle(
                                      color: Colors.white
                                    ),),
                                  ),
                            )),
                            Expanded(
                              flex: 3,
                                child: InkWell(
                                  onTap: () async{
                                    final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 50);
                                    if(image != null){
                                      photo = image;
                                      if(mounted){
                                        setState(() {

                                        });
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Container(
                                      child: Visibility(
                                        visible: photo == null,
                                          replacement: Text(photo?.name ?? ""),
                                          child: Text("Select a photo")),
                                                              ),
                                  ),
                                )),
                          ],
                        ),
                      );
  }
}

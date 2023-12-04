import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:task_manager_live_app/UI/Screens/edit_profile_screen.dart';
import 'package:task_manager_live_app/UI/Screens/login_screen.dart';
import 'package:task_manager_live_app/UI/controller/authentication_controller.dart';

class ProfileSummeryCard extends StatefulWidget {
  const ProfileSummeryCard({
    super.key, this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  State<ProfileSummeryCard> createState() => _ProfileSummeryCardState();
}

class _ProfileSummeryCardState extends State<ProfileSummeryCard> {
  @override
  Widget build(BuildContext context) {

    Uint8List imageBytes = const Base64Decoder().convert(AuthenticationController.user?.photo ?? "");
    return ListTile(
      onTap: (){
        if(widget.enableOnTap){
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
        }
      },
      leading:  CircleAvatar(
        child: AuthenticationController.user?.photo == null ? const Icon(Icons.person) : Image.memory(imageBytes),
      ),
      title:  Text(fullName,style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600
      ),),
      subtitle:  Text(AuthenticationController.user?.email ?? "",style: TextStyle(
        color: Colors.white,

      ),),
      trailing: IconButton(onPressed: () async{
        await AuthenticationController.clearAuthenticationData();
        if(mounted){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
        }

      }, icon: const Icon(Icons.logout,color: Colors.white,)),
      tileColor: Colors.green,
    );
  }

  String get fullName{
    return "${AuthenticationController.user?.firstName ?? ""} ${AuthenticationController.user?.lastName}";
  }
}
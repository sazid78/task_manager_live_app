import 'package:flutter/material.dart';
import 'package:task_manager_live_app/UI/Screens/login_screen.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_live_app/widgets/body_background.dart';
import 'package:task_manager_live_app/widgets/snack_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _firstNameTEcontroller = TextEditingController();
  final TextEditingController _lastNameTEcontroller = TextEditingController();
  final TextEditingController _mobileTEcontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signUpInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyBackground(
            child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text("Join With Us",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty ||!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value!)) {
                      return "Enter your valied email address";
                    }
                    return null;
                  },
                  controller: _emailTEcontroller,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "First Name",
                  ),
                  controller: _firstNameTEcontroller,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your first Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Last Name",
                  ),
                  controller: _lastNameTEcontroller,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your last Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Mobile",
                  ),
                  controller: _mobileTEcontroller,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your mobile number";
                    }
                    if (value!.length != 11) {
                      return "Your mobile number must have 11 digit";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passwordTEcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter the password";
                    }
                    if (value!.length < 6) {
                      return "Your password length must have more then 6 letter";
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _signUpInProgress == false,
                    replacement: Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: signUp,
                        child: Icon(Icons.arrow_circle_right_outlined)),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an account?",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(fontSize: 16),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    )));
  }

  Future<void> signUp()
    async {
      if (_formKey.currentState!.validate()) {
        _signUpInProgress = true;
        if(mounted){
          setState(() {

          });
        }
        final NetworkResponse response = await NetworkCaller()
            .postRequest(Urls.registration,body:{
          "email":_emailTEcontroller.text.trim(),
          "firstName":_firstNameTEcontroller.text.trim(),
          "lastName":_lastNameTEcontroller.text.trim(),
          "mobile":_mobileTEcontroller.text.trim(),
          "password":_passwordTEcontroller.text,
        });
        _signUpInProgress = false;
        if(mounted){
          setState(() {

          });
        }
        if (response.isSuccess) {
          if (mounted) {
            _clearTextField();
            SnackMessage(context, "Account Created SuccessFully");
          }else{
            if (mounted) {
              SnackMessage(context, "Accunt Creation Failed! Try Again",true);
            }
          }
        }
      }
    }




  void _clearTextField(){
    _emailTEcontroller.clear();
    _firstNameTEcontroller.clear();
    _lastNameTEcontroller.clear();
    _mobileTEcontroller.clear();
    _passwordTEcontroller.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEcontroller.dispose();
    _firstNameTEcontroller.dispose();
    _lastNameTEcontroller.dispose();
    _mobileTEcontroller.dispose();
    _passwordTEcontroller.dispose();
    super.dispose();
  }
}


import 'package:flutter/material.dart';
import 'package:task_manager_live_app/UI/Screens/login_screen.dart';
import 'package:task_manager_live_app/UI/Screens/pin_verification_screen.dart';
import 'package:task_manager_live_app/UI/Screens/sign_up_screen.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_live_app/widgets/body_background.dart';
import 'package:task_manager_live_app/widgets/snack_message.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({Key? key, required this.email, required this.otp}) : super(key: key);

  final String email,otp;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {

  final TextEditingController _passwordTEcontroller = TextEditingController();
  final TextEditingController _confirmPasswordTEcontroller = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyBackground(
            child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 180,),
                Text("Set Password",style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16,),
                Text("Minimum length password atleast 8 charrecters and with letter and number combination",style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14
                ),),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: _passwordTEcontroller,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: _confirmPasswordTEcontroller,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                  ),
                  validator: (String? value){
                    if((value?.isEmpty ?? true) || ((value ?? '') != _passwordTEcontroller.text)){
                      return "Password Not Match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){
                    _passwordConfirmation();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  }, child: Text("Confirm")),
                ),
                const SizedBox(height: 45,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an account?",style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54
                    ),),
                    TextButton(onPressed: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                    }, child: Text("Sign In",style: TextStyle(
                        fontSize: 16
                    ),))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    )));
  }

  Future<void> _passwordConfirmation() async{
    if (_formKey.currentState!.validate()) {
      final NetworkResponse response = await NetworkCaller().postRequest(
          Urls.resetPassword, body: {
        "email": widget.email,
        "OTP": widget.otp,
        "password": _passwordTEcontroller.text
      });
      if (response.isSuccess) {
        if (mounted) {
          SnackMessage(context, "Password Reset Successfull");
        }
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        if(mounted){
          SnackMessage(context, "Password Reset Failed! Try again later!");
        }
      }
    }
  }
}

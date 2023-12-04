import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_live_app/UI/Screens/set_password_screen.dart';
import 'package:task_manager_live_app/UI/Screens/sign_up_screen.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_live_app/widgets/body_background.dart';
import 'package:task_manager_live_app/widgets/snack_message.dart';

class PinVerificationScreen extends StatefulWidget {
  final String email;
  const PinVerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {

  final TextEditingController _pinVerificationTEcontroller = TextEditingController();
  bool _pinVerificationInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyBackground(
            child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 180,),
              Text("Pin Verification",style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16,),
              Text("A 6 digit verification OTP will send to your email address",style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16
              ),),
              const SizedBox(height: 16,),
              PinCodeTextField(
                controller: _pinVerificationTEcontroller,
                appContext: context,
                  length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  activeFillColor: Colors.white,
                  activeColor: Colors.green,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white
                ),
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                onCompleted: (v){
                  print("Complited");
                },
              ),
              const SizedBox(height: 24,),
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: _pinVerificationInProgress == false,
                  replacement: Center(child: CircularProgressIndicator(),),
                  child: ElevatedButton(onPressed: (){
                    _pinVerification();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SetPasswordScreen(email: widget.email,otp: _pinVerificationTEcontroller.text.trim(),)) );
                  }, child: Text("Verify")),
                ),
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
                    Navigator.pop(context);
                  }, child: Text("Sign In",style: TextStyle(
                      fontSize: 16
                  ),))
                ],
              ),
            ],
          ),
        ),
      ),
    )));
  }
  
  Future<void> _pinVerification() async{
    _pinVerificationInProgress = true;
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.pinVerification(widget.email, _pinVerificationTEcontroller.text.trim()));
    _pinVerificationInProgress = false;
    if(response.isSuccess){
      SnackMessage(context, "OTP verification Done");
      Navigator.push(context, MaterialPageRoute(builder: (context) => SetPasswordScreen(email: widget.email,otp: _pinVerificationTEcontroller.text.trim(),)));
    }else{
      SnackMessage(context, "OTP verification failed! try again later",false);
    }
  }
}

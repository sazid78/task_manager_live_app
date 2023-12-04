import 'package:flutter/material.dart';
import 'package:task_manager_live_app/UI/Screens/login_screen.dart';
import 'package:task_manager_live_app/UI/Screens/pin_verification_screen.dart';
import 'package:task_manager_live_app/UI/Screens/sign_up_screen.dart';
import 'package:task_manager_live_app/data.network_caller/network_caller.dart';
import 'package:task_manager_live_app/data.network_caller/network_response.dart';
import 'package:task_manager_live_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_live_app/widgets/body_background.dart';
import 'package:task_manager_live_app/widgets/snack_message.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController _emailTEcontroller = TextEditingController();
  bool _recoveryPasswordInProgress = false;

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
                      Text("Your Email Addresss", style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge),
                      const SizedBox(height: 16,),
                      Text(
                        "A 6 digit verification pic will send to your email address",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16
                        ),),
                      const SizedBox(height: 16,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                        ),
                        controller: _emailTEcontroller,
                      ),
                      const SizedBox(height: 24,),
                      SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: _recoveryPasswordInProgress == false,
                          replacement: Center(child: CircularProgressIndicator(),),
                          child: ElevatedButton(onPressed: () {
                            _forgetPassword();
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    PinVerificationScreen(
                                        email: _emailTEcontroller.text.trim())),
                            );
                          }, child: Icon(Icons.arrow_circle_right_outlined)),
                        ),
                      ),
                      const SizedBox(height: 45,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Have an account?", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54
                          ),),
                          TextButton(onPressed: () {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()), (
                                    route) => false);
                          }, child: Text("Sign In", style: TextStyle(
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

  Future<void> _forgetPassword() async {
    _recoveryPasswordInProgress = true;
      final NetworkResponse response = await NetworkCaller().getRequest(
          Urls.recoverEmail(_emailTEcontroller.text.trim()));
      _recoveryPasswordInProgress = false;
      setState(() {

      });
      if (response.isSuccess) {
        if (mounted) {
          SnackMessage(context, "OTP sent to your email address");
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              PinVerificationScreen(email: _emailTEcontroller.text.trim())));
        } else {
          if (mounted) {
            SnackMessage(context, "OTP send failed, try again later.");
          }
        }
      }
    }
  }

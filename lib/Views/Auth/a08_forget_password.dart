
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pepcorns_app/CustomWidgets/a02_round_button.dart';
import 'package:pepcorns_app/Utils/a04_utils_toast_message.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  hintText: 'Enter your Email'
              ),
            ),
            const SizedBox(height: 40,),
            RoundButton(title: 'Forget', onTap: (){
              auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
                Utils().toastMessage('We have sent you email to recover password, Please check email');
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            })
          ],
        ),
      ),
    );
  }
}

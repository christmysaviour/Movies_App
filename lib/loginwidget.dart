import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



class LoginPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginPage({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 40),
        TextField(
          controller: emailController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        const SizedBox(height: 40),
        TextField(
          controller: passwordController,
          textInputAction: TextInputAction.none,
          cursorColor: Colors.white,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
          ),
            onPressed: (){
            LogIn();
            },
            icon: const Icon(Icons.lock_open , size: 32),
            label: const Text(
              'Sign In',
              style:  TextStyle(fontSize: 24),
            ),
        ),
        Center(
          child: RichText(text: TextSpan(

            style: const TextStyle(color: Colors.black),
            text: "No Account? ",
            children: [
              TextSpan(
                text: 'Sign Up',
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedSignUp,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.secondary,
                )
              ),

            ]
          )),
        )
      ],
    ),
  );
  Future LogIn() async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    }on FirebaseAuthException catch (e){
      print(e);
    }
  }

}


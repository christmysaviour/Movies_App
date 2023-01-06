import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUp extends StatefulWidget {
  final Function() onClickedLogin;
  const SignUp({Key? key, required this.onClickedLogin}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              onPressed: () {
                signIn();
              },
              icon: const Icon(Icons.lock_open, size: 32),
              label: Text(
                'Sign Up',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
                onPressed: () async {
                  await googleLogin();
                },
                icon: const Icon(Icons.key,size:32),
                label: const Text("Sign In With Google",style: TextStyle(fontSize: 24),),

            ),
            Center(
              child: RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      text: "Already having an account? ",
                      children: [
                    TextSpan(
                        text: 'Log In',
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedLogin,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary,
                        ))
                  ])),
            )
          ],
        ),
      );

  Future signIn() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}

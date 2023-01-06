import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:src/home.dart';
import 'package:src/loginwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:src/signup.dart';

import 'auth_page.dart';

Future  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GlsignIn(),
        theme: ThemeData(
          brightness:Brightness.dark,
          primaryColor: Colors.green,)

    );
  }


}
class GlsignIn extends StatelessWidget {
  const GlsignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<User?>(
         stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context,snapshot){
           if(snapshot.hasData)
              return HomePage();
           else{
             return AuthPage();
           }
         },
      ),
    );
  }
}


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return HomePage();
        }else{
          return AuthPage();
        }
      }
    ),
    );
  }
}




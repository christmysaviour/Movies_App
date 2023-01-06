import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:src/searhelp.dart';

import 'Services/RemoteServices.dart';
import 'Widgets/nowPlaying.dart';
import 'Widgets/popular.dart';
import 'Widgets/topRated.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness:Brightness.dark,
          primaryColor: Colors.green,)

    );
  }


}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    loadmovies();
    // TODO: implement initState
    super.initState();
  }
  List popularmovieslist = [];
  List topratedmovieslist = [];
  List nowplayingmovieslist = [];
  List tempList = [];

  final String apiKey = 'b93f5439608f8df1ce076d0b03efaef0';
  final readacesstoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiOTNmNTQzOTYwOGY4ZGYxY2UwNzZkMGIwM2VmYWVmMCIsInN1YiI6IjYzYTNlNmFlZTI0YjkzMDA5M2YzMzg5YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qDNDRIeIBaXsXIXO4St1Pxlq1TSID1gSWz_2Z-PzZxA';
  loadmovies()async{

    var popularMovies =await RemoteServices().getPopular();
    var topRatedMovies = await RemoteServices().getTopRated();
    var nowPlayingMovies = await RemoteServices().getStreaming();

    setState(() {
      popularmovieslist = popularMovies['results'];
      topratedmovieslist = topRatedMovies['results'];
      nowplayingmovieslist = nowPlayingMovies['results'];

    });
    // print(popularMovies['results']);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Flutter  App',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30
          ),
        ),
        toolbarHeight: 100,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          TopRated(topRated: topratedmovieslist),
          Popular(popular: popularmovieslist),
          NowPlaying(playing: nowplayingmovieslist),
        ],
      ),
      drawer: Drawer(

        width: 200,
        child: Column(

          children: [
            SizedBox(
              height: 250,
            ),
            Container(
                width: double.maxFinite,
                child: OutlinedButton(onPressed:()async{
                 await FirebaseAuth.instance.signOut();
                  await GoogleSignIn().signOut();
                  }, child: Text('Sign Out'))
            ),
            Container(
              width: double.maxFinite,
              child: OutlinedButton(onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>const Search()));
              }, child: Text("Search")),
            )

          ],
        ),
      ),
    );
  }
}


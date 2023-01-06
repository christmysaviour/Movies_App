import 'package:flutter/material.dart';


class Description extends StatelessWidget {
  final String ?overview;
  final dynamic rating;
  final String ?name;
  final String? img_url;


  const Description({Key? key, required this.overview, required this.rating, required this.name, required this.img_url}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        title: Text(name!),
      ) ,
      body: ListView(
        children:  [
            SizedBox(
              height: 300,
              width: double.infinity,
              child:Image(
                image: NetworkImage('https://image.tmdb.org/t/p/w500/$img_url'),
              )
            ),
            Container(
              padding: const  EdgeInsets.all(20),
              child: Text(
                  overview!,
                  style:const TextStyle(
                    wordSpacing: 10,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                  )
              ),

            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
              'Rating - $rating',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 30,
                color: Colors.amber
              ),
              ),
            )
          ],
        ),

    );
  }
}

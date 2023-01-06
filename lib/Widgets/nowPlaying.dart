import 'package:flutter/material.dart';

import '../description.dart';

class NowPlaying extends StatelessWidget {
  final List playing;
  const NowPlaying({Key? key, required this.playing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              'Now Streaming',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),
          ),
          Container(
            height:270,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: playing.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>Description(overview: playing[index]['overview'], rating: playing[index]['vote_average'], name: playing[index]['original_title'], img_url: playing[index]['poster_path'])));
                    },
                    child: Container(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            height:200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:NetworkImage('https://image.tmdb.org/t/p/w500/'+playing[index]['poster_path'])
                                )
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 70,
                            child: Text(
                                playing[index]['original_title'],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),),
                          )
                        ],
                      ),
                    ),
                  );
                }
            ),
          )

        ],
      ),
    );
  }
}

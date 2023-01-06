import 'package:flutter/material.dart';

import '../description.dart';


class Popular extends StatelessWidget {
  final List popular;
  const Popular({Key? key, required this.popular}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Popular",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          Container(
            height: 270,

            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popular.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>Description(overview: popular[index]['overview'], rating: popular[index]['vote_average'], name: popular[index]['original_title'], img_url: popular[index]['poster_path'])));
                    },
                    child: Container(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            height:200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:NetworkImage('https://image.tmdb.org/t/p/w500/'+popular[index]['poster_path'])
                                )
                            ),

                          ),
                          Container(
                              height: 70,
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                popular[index]['original_title'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                          )
                        ],
                      ),
                    ),

                  );
                }
            ),

          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:src/description.dart';
class TopRated extends StatelessWidget {
  final List topRated;
  const TopRated({Key? key, required this.topRated}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Top Rated",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        Container(
          height: 270,

          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topRated.length,
            itemBuilder: (context,index){
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>Description(overview: topRated[index]['overview'], rating: topRated[index]['vote_average'], name: topRated[index]['original_title'], img_url: topRated[index]['poster_path'])));
                },
                child: Container(
                  width: 140,
                  child: Column(
                    children: [
                      Container(
                        height:200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:NetworkImage('https://image.tmdb.org/t/p/w500/'+topRated[index]['poster_path'])
                          )
                        ),

                      ),
                      Container(
                        height: 70,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                            topRated[index]['original_title'],
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

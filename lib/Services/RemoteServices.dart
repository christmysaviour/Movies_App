import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:src/Modals/Mov.dart';


class RemoteServices{
  Future<dynamic> getPopular() async {
    var client = http.Client();
    var url = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=b93f5439608f8df1ce076d0b03efaef0');
    var response = await client.get(url);
    if(response.statusCode==200){
      var json = response.body;
      return jsonDecode(json);
    }
    else{
      return null;
    }
  }
  Future<dynamic> getTopRated() async {
    var client = http.Client();
    var url = Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=b93f5439608f8df1ce076d0b03efaef0');
    var response = await client.get(url);
    if(response.statusCode==200){
      var json = response.body;
      return jsonDecode(json);
    }
    else{
      return null;
    }
  }
  Future<dynamic> getStreaming() async {
    var client = http.Client();
    var url = Uri.parse('https://api.themoviedb.org/3/movie/now_playing?api_key=b93f5439608f8df1ce076d0b03efaef0');
    var response = await client.get(url);
    if(response.statusCode==200){
      var json = response.body;
      return jsonDecode(json);
    }
    else{
      return null;
    }
  }
  Future<dynamic> getSearch(s) async {
    var client = http.Client();
    var url = Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=b93f5439608f8df1ce076d0b03efaef0&language=en-US&page=1&include_adult=false&query=$s');
    var response = await client.get(url);
    if(response.statusCode==200){
      var json = response.body;
      return jsonDecode(json);
    }
    else{
      return null;
    }
  }
}
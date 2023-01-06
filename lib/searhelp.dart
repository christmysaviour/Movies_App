import 'package:flutter/material.dart';

import 'Services/RemoteServices.dart';
import 'description.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  _SearchState(){
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  final TextEditingController _filter = TextEditingController(); String _searchText = "";
  List names = []; // names we get from API
  List filteredNames = []; // names filtered by search text
  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBarTitle = const Text('Search Movie');

  void _getNames(s) async {
    dynamic res =
    await RemoteServices().getSearch(s);
    var response = res['results'];
    List tempList = [];
    for (int i = 0; i < response.length; i++) {
      tempList.add(response[i]);
    }
    setState(() {
      names = tempList;
      filteredNames = names;
    });
  }

  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.close);
        _appBarTitle = TextField(
          onChanged: (s) {
            _getNames(s);
          },
          controller: _filter,
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        _searchIcon = const Icon(Icons.search);
        _appBarTitle = const Text('Search Mov');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

    Widget _buildList() {
      // if (_searchText.isNotEmpty) {
      //   List tempList = [];
      //   for (int i = 0; i < filteredNames.length; i++) {
      //     if (filteredNames[i]['name']
      //         .toLowerCase()
      //         .contains(_searchText.toLowerCase())) {
      //       tempList.add(filteredNames[i]);
      //     }
      //   }
      //   filteredNames = tempList;
      // }
      return ListView.builder(
        itemCount: names == null ? 0 : filteredNames.length,
        itemBuilder: (context,  index) {
          return ListTile(
            title: Text(filteredNames[index]['original_title']),
           onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context)=>Description(overview: filteredNames[index]['overview'], rating: filteredNames[index]['vote_average'], name: filteredNames[index]['original_title'], img_url: filteredNames[index]['poster_path']))),
          );
        },
      );
    }
    Widget _buildBar(BuildContext context) {
      return AppBar(
        title: _appBarTitle,
        leading: IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,
        ),
      );
    }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:  Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 40,top: 10),
            child: _buildBar(context)
        ),
      ) ,
      body: Container(
        child: _buildList(),
      ),
    );
  }
}


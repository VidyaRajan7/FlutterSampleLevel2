import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends  State<SearchList> {

  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  bool isSearchListNeeded = false;

  _SearchListState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
          isSearchListNeeded = false;
          _searchIcon = new Icon(Icons.search);
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          height:40,
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width - 40,
          child: _buildBar(),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                  color: Colors.grey,
                  width: 0.2
              )
          ),
          margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
        ),
        isSearchListNeeded ? Container(
          height: 400,
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: ListView.builder(
            itemCount: names == null ? 0 : filteredNames.length,
            itemBuilder: (BuildContext context, int index) {
              return new ListTile(
                title: Text(filteredNames[index]['title']),
                onTap: () => {},
              );
            },
          ),
        ) : Container()
      ]
    );
  }

  Widget _buildBar() {
    return new Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: 50,
          child: new IconButton(
              icon: _searchIcon,
              onPressed: () => {
                _searchPressed()
              }),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 108,
          child: TextField(
            controller: _filter,
            decoration: new InputDecoration(
                hintText: 'Search...'),
          ),
        )
      ],
    );
  }

  void _getNames() async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/albums');
    //https://reqres.in/api/users
    List tempList = new List();
    for (int i=0; i< response.data.length; i++) {
      tempList.add(response.data[i]);
    }
    setState(() {
      names = tempList;
      filteredNames = names;
      _buildList();
    });
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        _buildList();
      } else {
        this._searchIcon = new Icon(Icons.search);
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['title'].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      if (tempList.length > 0) {
        setState(() {
          filteredNames = tempList;
          isSearchListNeeded = true;
        });
      }
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['title']),
          onTap: () {},
        );
      },
    );
  }
}


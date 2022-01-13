import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController _searchController;
  final Function getMeaning;
  SearchInput(this._searchController, this.getMeaning);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
                hintText: "Enter the word here",
                labelText: "Search",
                labelStyle: TextStyle(fontSize: 24, color: Colors.black),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => getMeaning(_searchController.text),
                )),
            maxLength: 15,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Word : ' + _searchController.text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

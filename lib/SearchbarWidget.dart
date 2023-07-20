import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
  
  final Future<void> Function(String) onSubmitted;

  CustomSearchBar({required this.onSubmitted});

}


class _SearchBarState extends State<CustomSearchBar> {
  String _searchText = '';
  TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> handleSubmitted(String searchTerm) async {
    if (widget.onSubmitted != null) {
      await widget.onSubmitted(searchTerm);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.search,size: 40),
        SizedBox(width: 25),
        Container(
          width: MediaQuery.of(context).size.width/3,
          child: TextField(
            controller: _searchController,
            style: TextStyle(fontSize: 30),
            onSubmitted: handleSubmitted,
            onChanged: (value) {
              setState(() {
                _searchText = value;
              });
            },
            decoration: InputDecoration(
              fillColor: Colors.white,filled: true,
              hintText: 'Summoner name',
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _searchController.clear();
                    _searchText = '';
                  });
                })
            )
          ),
        ),
      ],
    );
  }
}
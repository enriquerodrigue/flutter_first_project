import 'package:flutter/material.dart';
import 'package:flutter_first_project/SearchbarWidget.dart';

class HomeScreen extends StatelessWidget {
  //const HomeScreen({super.key});
  var summoner = 'Enrito';

  void goToPlayer(context, ) {
    Navigator.push(context, '/playerinfo');
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Column(
          children: [
            Center(
              child: Container(
                child: CustomSearchBar(
                  onSubmitted: (value){Navigator.pushNamed(context, '/playerinfo',arguments: value);},
                )
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                     '/playerinfo',
                     arguments: summoner
                     );
                },
                child: Text(
                  'Welcome'
                ) ),
            ),
          ],
        ),
      );
  }
}
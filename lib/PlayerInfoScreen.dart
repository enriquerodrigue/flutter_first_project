import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_first_project/SearchbarWidget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class PlayerInfoScreen extends StatefulWidget {
  @override
  _PlayerInfoScreenState createState() => _PlayerInfoScreenState();
}

class _PlayerInfoScreenState extends State<PlayerInfoScreen> {
  var summonerName = "";
  var summonerLevel = "";
  var playerInfo = "";
  var iconUrl = "";
  var iconId = "";
  var playerId = "";
  var rankName= "";
  var tier = "";
  var otherTier = "";
  var division = "";
  var otherDivision = "";
  var hotStreak = "";
  var apiKey =  dotenv.env['API_KEY'];

Future<void> fetchData(String playerName) async {
  var url = Uri.parse('https://na1.api.riotgames.com/lol/summoner/v4/summoners/by-name/$playerName?api_key=$apiKey'); // Replace with your API endpoint
  var response = await http.get(url);

  if (response.statusCode == 200) {
    // API call successful
    var data = jsonDecode(response.body); // Handle the response data
    iconId = data['profileIconId'].toString();
    playerId = data['id'];
    rankedInfo(playerId);
    
    setState(() {
      summonerName = data['name'];
      iconUrl = 'http://ddragon.leagueoflegends.com/cdn/13.13.1/img/profileicon/$iconId.png';
      summonerLevel = data['summonerLevel'].toString();
    });
    //print(data);
  } else {
    // API call failed
    print('Request failed with status: ${response.statusCode}');
  }
}

Future<void> rankedInfo(String playerId) async {
  var rankedUrl = Uri.parse('https://na1.api.riotgames.com/lol/league/v4/entries/by-summoner/$playerId?api_key=$apiKey');
  var response = await http.get(rankedUrl);

  var rankedData = jsonDecode(response.body);
  var firstRankIndx =  0;//rankedData.length > 1 ? 1 : 0;
  var secondRankIndx = 1;

  setState(() {
    tier = rankedData[firstRankIndx]['tier'];
    otherTier = rankedData.length > 1 ? rankedData[secondRankIndx]['tier'] : ""; 
    division = tier != "MASTER" && tier != "GRANDMASTER" && tier != "CHALLENGER" ? rankedData[firstRankIndx]['rank'] : "";
    otherDivision = otherTier != "MASTER" && otherTier != "GRANDMASTER" && otherTier != "CHALLENGER" && otherTier != "" ? rankedData[secondRankIndx]['rank'] : "";
    hotStreak = rankedData[firstRankIndx]['hotStreak'] || rankedData[secondRankIndx]['hotStreak'] ? "🔥" : "";
  });
}

Future<void> Function(String) get searchCallback => fetchData;

  @override
  Widget build(BuildContext context) {

    var summoner = ModalRoute.of(context)!.settings.arguments;
    print(summoner);
    return Scaffold(
        // Your app content
        appBar: AppBar(
          title: Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("YOU.GG",
                style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),
              ),
              CustomSearchBar(
                onSubmitted:
                  searchCallback
                  )
            ],
          ),
          toolbarHeight: 100,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column( 
              children: [
                SizedBox(height: 20),
                Text("$summonerName $hotStreak",style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                iconUrl != "" ? Image.network(iconUrl) : Container(),
                SizedBox(height: 20),
                Text(iconId != "" ? "Summoner level: $summonerLevel" : "", style: TextStyle(fontSize: 50)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(tier != "" ? "Your rank is $tier $division"  : "",style: TextStyle(fontSize: 50)),
                        tier != "" ? Image.asset("assets/emblem-$tier.png") : Container()
                      ],
                    ),
                    SizedBox(width: 100),
                    Column(
                      children: [
                        Text(otherTier != "" ? "Your rank is $otherTier $otherDivision"  : "",style: TextStyle(fontSize: 50)),
                        otherTier != "" ? Image.asset("assets/emblem-$otherTier.png") : Container()
                      ],
                    ),
                  ],
                ),
            ],
          )),
        )
      );
  }
}

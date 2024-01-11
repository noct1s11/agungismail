import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShopPage extends StatelessWidget {
  Future<List<Team>> getTeams() async {
    var response = await http.get(Uri.https('balldontlie.io', 'api/v1/teams'));
    
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<Team> teams = [];

      for (var eachTeam in jsonData['data']) {
        final team = Team(
          abbreviation: eachTeam['abbreviation'],
          city: eachTeam['city'],
        );
        teams.add(team);
      }

      return teams;
    } else {
      throw Exception('Failed to load teams. Please try again later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: TeamList(),
    );
  }
}

class TeamList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ShopPage().getTeams(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<Team> teams = snapshot.data as List<Team>;

          return ListView.builder(
            itemCount: teams.length,
            itemBuilder: (context, index) {
              return TeamItem(team: teams[index]);
            },
          );
        }
      },
    );
  }
}

class TeamItem extends StatelessWidget {
  final Team team;

  const TeamItem({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          title: Text(team.abbreviation),
          subtitle: Text(team.city),
        ),
      ),
    );
  }
}

class Team {
  final String abbreviation;
  final String city;

  Team({required this.abbreviation, required this.city});
}

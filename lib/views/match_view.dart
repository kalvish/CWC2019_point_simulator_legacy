import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cwc2019_point_simulator/models/match_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchView extends StatefulWidget {
  final MatchCard matchCard;

  MatchView({this.matchCard});

  @override
  _MatchViewState createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> {
  MatchCard matchCard;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    matchCard = widget.matchCard;
//    print(matchCard);
//    saveThisMatchToPrefs(matchCard);
  }

  Future<bool> saveThisMatchToPrefs(MatchCard matchCard) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = jsonEncode(matchCard);
    return prefs.setString(matchCard.id.toString(), json);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Material(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0)),
            elevation: 5.0,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Match #${matchCard.id}'),
                      Text('at ${matchCard.venue}'),
                      Text('${matchCard.date}'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DecoratedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Image.asset(
                            'images/${matchCard.teamA.replaceAll(new RegExp(r"\s+\b|\b\s"), "")}.png' ??
                                'noimage.png',
                            width: 50,
                            height: 34,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey[300]),
                        ),
                      ),
                      Text('${matchCard.teamAScore}/${matchCard.teamAWickets}'),
                      DecoratedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Image.asset(
                            'images/${matchCard.teamB.replaceAll(new RegExp(r"\s+\b|\b\s"), "")}.png' ??
                                'noimage.png',
                            width: 50,
                            height: 34,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey[300]),
                        ),
                      ),
                      Text('${matchCard.teamBScore}/${matchCard.teamBWickets}'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: FlatButton(
                          onPressed: () async {
                            if (matchCard.completed != null &&
                                !matchCard.completed) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              matchCard.Winner = matchCard.teamA;
                              matchCard.abandoned = '0';
                              matchCard.tied = '0';
                              matchCard.userEdited = 'true';
                              String json = jsonEncode(matchCard);
                              print(json);
                              prefs.setString(matchCard.id.toString(), json);
                              setState(() {});
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                matchCard.teamA,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Icon(
                                (matchCard.Winner == matchCard.teamA)
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: (matchCard.Winner == matchCard.teamA)
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: FlatButton(
                          onPressed: () async {
                            if (matchCard.completed != null &&
                                !matchCard.completed) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              matchCard.Winner = matchCard.teamB;
                              matchCard.abandoned = '0';
                              matchCard.tied = '0';
                              matchCard.userEdited = 'true';
                              String json = jsonEncode(matchCard);
                              print(json);
                              prefs.setString(matchCard.id.toString(), json);
                              setState(() {});
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                matchCard.teamB,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Icon(
                                (matchCard.Winner == matchCard.teamB)
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: (matchCard.Winner == matchCard.teamB)
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: FlatButton(
                          onPressed: () async {
                            if (matchCard.completed != null &&
                                !matchCard.completed) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              matchCard.Winner = "";
                              matchCard.abandoned = '0';
                              matchCard.tied = '1';
                              matchCard.userEdited = 'true';
                              String json = jsonEncode(matchCard);
                              print(json);
                              prefs.setString(matchCard.id.toString(), json);
                              setState(() {});
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Tied',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Icon(
                                (matchCard.tied == '1')
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: (matchCard.tied == '1')
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: FlatButton(
                          onPressed: () async {
                            if (matchCard.completed != null &&
                                !matchCard.completed) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              matchCard.Winner = "";
                              matchCard.abandoned = '1';
                              matchCard.tied = '0';
                              matchCard.userEdited = 'true';
                              String json = jsonEncode(matchCard);
                              print(json);
                              prefs.setString(matchCard.id.toString(), json);
                              setState(() {});
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Abandoned',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Icon(
                                (matchCard.abandoned == '1')
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                color: (matchCard.abandoned == '1')
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

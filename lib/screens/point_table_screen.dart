import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cwc2019_point_simulator/models/match_card.dart';
import 'package:cwc2019_point_simulator/models/country_points.dart';

class PointTable extends StatefulWidget {
  static const String id = 'point_table_screen';
  @override
  _PointTableState createState() => _PointTableState();
}

class _PointTableState extends State<PointTable> {
//  final String jsonSample =
//      '[{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India","area":"abc"},{"name":"Shyam","email":"shyam23@gmail.com",'
//      '"age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India",'
//      '"area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India","area":"abc","day":"Monday","month":"april"},'
//      '{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com",'
//      '"age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India",'
//      '"area":"abc","day":"Monday","month":"april"},{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},'
//      '{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,'
//      '"income":"10Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc",'
//      '"day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"}]';
//
//  final String jsonMatchData =
//      '[{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":1,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":2,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":3,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":4,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":5,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":6,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":7,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":8,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":9,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":10,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":11,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":12,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":13,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":14,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":15,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":16,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":17,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":18,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":19,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":20,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":21,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":22,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":23,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":24,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":25,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":26,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":27,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":28,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":29,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":30,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":31,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":32,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":33,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":34,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":35,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":36,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":37,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":38,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":39,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":40,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":41,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":42,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"311","teamBOvers":"39","completed":false,"teamAWickets":"8","teamBWickets":"10","teamBScore":"207","Winner":"England","teamA":"England","teamB":"South Africa","id":43,"abandoned":"0","firstBat":"England","teamABalls":"0","teamBBalls":"5"},{"teamAOvers":"50","tied":"0","teamAScore":"105","teamBOvers":"13.4","completed":false,"teamAWickets":"10","teamBWickets":"3","teamBScore":"108","Winner":"West Indies","teamA":"Pakistan","teamB":"West Indies","id":44,"abandoned":"0","firstBat":"Pakistan","teamABalls":"0","teamBBalls":"5"}]';
//
//  String jsonPointTableSample =
//      '[{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"}]';

  String pTS =
      '[{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"}]';

  bool toggle = true;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _isLoading = false;

    loadData();
  }

  void loadData() async {
    pTS = await loadingPointTable();
//    await Future.delayed(const Duration(seconds: 3));
//    jsonPointTableSample =
//        '[{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"},{"Team":"New Zealand","M":"2","W":"2","L":"0","T":0,"N/R":"0","PT":"4","NRR":"2.279","For":"385/63.2","Against":"380/100.0"}]';
    _isLoading = true;
    setState(() {});
  }

  Future<String> loadingPointTable() async {
//    Map<int, MatchCard> matchCards = Map<int, MatchCard>();
    List<MatchCard> matchCardList = List<MatchCard>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> prefKeys = prefs.getKeys();
    for (var key in prefKeys) {
      if (key != null) {
        String getString = prefs.getString(key.toString());
        print(getString);
        if (getString != null) {
          Map map = json.decode(getString);
          print(map);
          MatchCard matchCard = MatchCard.fromMap(map);
          print(matchCard.teamA);
          //MatchCard fromInternet = matchCards[matchCard.id];
//          if (fromInternet.completed && matchCard.userEdited == 'true') {
//            //skip saving from shared prefs. since it is completed, should fetch from backend.
//          } else {
//          matchCards[matchCard.id] = matchCard;
          matchCardList.add(matchCard);
//          }
        }
      }
    }

    Map<String, CountryPoints> countries = Map();
    CountryPoints afghanistan = CountryPoints();
    countries['Afghanistan'] = afghanistan;
    CountryPoints australia = CountryPoints();
    countries['Australia'] = australia;
    CountryPoints bangladesh = CountryPoints();
    countries['Bangladesh'] = bangladesh;
    CountryPoints england = CountryPoints();
    countries['England'] = england;
    CountryPoints india = CountryPoints();
    countries['India'] = india;
    CountryPoints newZealand = CountryPoints();
    countries['New Zealand'] = newZealand;
    CountryPoints pakistan = CountryPoints();
    countries['Pakistan'] = pakistan;
    CountryPoints southAfrica = CountryPoints();
    countries['South Africa'] = southAfrica;
    CountryPoints sriLanka = CountryPoints();
    countries['Sri Lanka'] = sriLanka;
    CountryPoints westIndies = CountryPoints();
    countries['West Indies'] = westIndies;

    for (var card in matchCardList) {
      CountryPoints teamA = countries[card.teamA];
      CountryPoints teamB = countries[card.teamB];

      //match is completed
      if (card.completed) {
        teamA.M = teamA.M + 1;
        teamB.M = teamB.M + 1;

        teamA = countries[card.teamA];
        teamA.Team = card.teamA;
        teamB = countries[card.teamB];
        teamB.Team = card.teamB;
        if (card.tied == '1') {
          teamA.PT = teamA.PT + 1;
          teamB.PT = teamB.PT + 1;

          teamA.T = teamA.T + 1;
          teamB.T = teamB.T + 1;
        } else if (card.abandoned == '1') {
          teamA.PT = teamA.PT + 1;
          teamB.PT = teamB.PT + 1;

          teamA.NR = teamA.NR + 1;
          teamB.NR = teamB.NR + 1;
        }
        if (card.Winner == card.teamA) {
          teamA.PT = teamA.PT + 2;
          teamA.W = teamA.W + 1;
          teamB.L = teamB.L + 1;

          //debug
          if (teamB.Team == 'South Africa') {
            int a = 0;
          }
          double teamABallRatio = 0;
          double teamBBallRatio = 0;
          double ballsA = double.parse(card.teamABalls);
          if (ballsA != 0) {
            teamABallRatio = ballsA / 6.0;
          }
          double ballsB = double.parse(card.teamBBalls);
          if (ballsB != 0) {
            teamBBallRatio = ballsB / 6.0;
          }
          //for winning team
          teamA.scoreFor = teamA.scoreFor + double.parse(card.teamAScore);
          teamA.scoreAg = teamA.scoreAg + double.parse(card.teamBScore);
          double oversFor = double.parse(card.teamAOvers) + teamABallRatio;
          teamA.oversFor = teamA.oversFor + oversFor;
          double oversAg = double.parse(card.teamBOvers) + teamBBallRatio;
          teamA.oversAg = teamA.oversAg + oversAg;
          teamA.For = '${teamA.scoreFor}/${teamA.oversFor.toStringAsFixed(3)}';
          teamA.Against =
              '${teamA.scoreAg}/${teamA.oversAg.toStringAsFixed(3)}';

          //for losing team
          teamB.scoreFor = teamB.scoreFor + double.parse(card.teamBScore);
          teamB.scoreAg = teamB.scoreAg + double.parse(card.teamAScore);
          double oversForLosingTeam =
              double.parse(card.teamBOvers) + teamBBallRatio;
          teamB.oversFor = teamB.oversFor + oversForLosingTeam;
          double oversAgWinningTeam =
              double.parse(card.teamAOvers) + teamABallRatio;
          teamB.oversAg = teamB.oversAg + oversAgWinningTeam;
          teamB.For = '${teamB.scoreFor}/${teamB.oversFor.toStringAsFixed(3)}';
          teamB.Against =
              '${teamB.scoreAg}/${teamB.oversAg.toStringAsFixed(3)}';

          //winner nrr
          double teamARatioFor = teamA.scoreFor / teamA.oversFor;
          double teamARatioAg = teamA.scoreAg / teamA.oversAg;
          double nrrA = (teamARatioFor - teamARatioAg);
          teamA.NRR = double.parse(nrrA.toStringAsFixed(3));

          //loser nrr
          double teamBRatioFor = teamB.scoreFor / teamB.oversFor;
          double teamBRatioAg = teamB.scoreAg / teamB.oversAg;
          double nrrB = (teamBRatioFor - teamBRatioAg);
          teamB.NRR = double.parse(nrrB.toStringAsFixed(3));
        } else if (card.Winner == card.teamB) {
          teamB.PT = teamB.PT + 2;
          teamB.W = teamB.W + 1;
          teamA.L = teamA.L + 1;

          //debug
          if (teamA.Team == 'South Africa') {
            int a = 0;
          }

          double teamABallRatio = 0;
          double teamBBallRatio = 0;
          double ballsA = double.parse(card.teamABalls);
          if (ballsA != 0) {
            teamABallRatio = ballsA / 6.0;
          }
          double ballsB = double.parse(card.teamBBalls);
          if (ballsB != 0) {
            teamBBallRatio = ballsB / 6.0;
          }

          //for winning team
          teamB.scoreFor = teamB.scoreFor + double.parse(card.teamBScore);
          teamB.scoreAg = teamB.scoreAg + double.parse(card.teamAScore);
          double oversFor = double.parse(card.teamBOvers) + teamBBallRatio;
          teamB.oversFor = teamB.oversFor + oversFor;
          double oversAg = double.parse(card.teamAOvers) + teamABallRatio;
          teamB.oversAg = teamB.oversAg + oversAg;
          teamB.For = '${teamB.scoreFor}/${teamB.oversFor.toStringAsFixed(3)}';
          teamB.Against =
              '${teamB.scoreAg}/${teamB.oversAg.toStringAsFixed(3)}';

          //for losing team
          teamA.scoreFor = teamA.scoreFor + double.parse(card.teamAScore);
          teamA.scoreAg = teamA.scoreAg + double.parse(card.teamBScore);
          double oversForLosingTeam =
              double.parse(card.teamAOvers) + teamABallRatio;
          teamA.oversFor = teamA.oversFor + oversForLosingTeam;
          double oversAgWinningTeam =
              double.parse(card.teamBOvers) + teamBBallRatio;
          teamA.oversAg = teamA.oversAg + oversAgWinningTeam;
          teamA.For = '${teamA.scoreFor}/${teamA.oversFor.toStringAsFixed(3)}';
          teamA.Against =
              '${teamA.scoreAg}/${teamA.oversAg.toStringAsFixed(3)}';

          //winner nrr
          double teamBRatioFor = teamB.scoreFor / teamB.oversFor;
          double teamBRatioAg = teamB.scoreAg / teamB.oversAg;
          double nrrB = (teamBRatioFor - teamBRatioAg);
          teamB.NRR = double.parse(nrrB.toStringAsFixed(3));

//          loser nrr
          double teamARatioFor = teamA.scoreFor / teamA.oversFor;
          double teamARatioAg = teamA.scoreAg / teamA.oversAg;
          double nrrA = (teamARatioFor - teamARatioAg);
          teamA.NRR = double.parse(nrrA.toStringAsFixed(3));
        }

//        countries[card.teamA] = teamA;
//        countries[card.teamB] = teamB;
      }
      if (!card.completed && card.userEdited == 'true') {
        teamA.M = teamA.M + 1;
        teamB.M = teamB.M + 1;

        teamA = countries[card.teamA];
        teamA.Team = card.teamA;
        teamB = countries[card.teamB];
        teamB.Team = card.teamB;
        if (card.tied == '1') {
          teamA.PT = teamA.PT + 1;
          teamB.PT = teamB.PT + 1;

          teamA.T = teamA.T + 1;
          teamB.T = teamB.T + 1;
        } else if (card.abandoned == '1') {
          teamA.PT = teamA.PT + 1;
          teamB.PT = teamB.PT + 1;

          teamA.NR = teamA.NR + 1;
          teamB.NR = teamB.NR + 1;
        }
        if (card.Winner == card.teamA) {
          teamA.PT = teamA.PT + 2;
          teamA.W = teamA.W + 1;
          teamB.L = teamB.L + 1;
        } else if (card.Winner == card.teamB) {
          teamB.PT = teamB.PT + 2;
          teamB.W = teamB.W + 1;
          teamA.L = teamA.L + 1;
        }
      }
      countries[card.teamA] = teamA;
      countries[card.teamB] = teamB;
    }
//    String pointTableString = "";
//    return pointTableString;
//    final sorted = new SplayTreeMap<String, dynamic>.from(
//        map, (a, b) => map[a]['rank'].compareTo(map[b]['rank']));

    List<CountryPoints> cp = List<CountryPoints>();
    countries.forEach((k, v) {
      cp.add(v);
    });

//    cp.sort((a, b) => b.PT.compareTo(a.PT));
    cp.sort((a, b) => compareFunction(a, b));
    cp.reversed.toList();
    String jsonCountries = jsonEncode(cp);
    String pointTableString = "";
    return jsonCountries;
  }

  int compareFunction(CountryPoints a, CountryPoints b) {
    if (b.PT.compareTo(a.PT) != 0) {
      return b.PT.compareTo(a.PT);
    } else {
      return b.NRR.compareTo(a.NRR);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loadRelevantWidget(context);
  }

  Widget _loadRelevantWidget(BuildContext context) {
    if (!_isLoading) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SpinKitWave(
              color: Colors.teal,
              size: 50,
            ),
          ),
        ),
      );
    } else {
      var json = jsonDecode(pTS);
//      var json = jsonDecode(jsonPointTableSample);
      return Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
                left: 10.0, right: 10.0, top: 100.0, bottom: 10.0),
            child: toggle
                ? Column(
                    children: [
                      JsonTable(
                        json,
                        tableHeaderBuilder: (String header) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.5),
                                color: Colors.grey[300]),
                            child: Text(
                              header,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0,
                                      color: Colors.black87),
                            ),
                          );
                        },
                        tableCellBuilder: (value) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 2.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey.withOpacity(0.5))),
                            child: Text(
                              value,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(
                                      fontSize: 14.0, color: Colors.grey[900]),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
//                      Text(
//                          "Simple table which creates table direclty from json")
                    ],
                  )
                : Center(
                    child: Text(getPrettyJSONString(pTS)),
                  ),
          ),
        ),
//        floatingActionButton: FloatingActionButton(
//            child: Icon(Icons.grid_on),
//            onPressed: () {
//              setState(
//                () {
//                  toggle = !toggle;
//                },
//              );
//            }),
      );
    }
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }
}

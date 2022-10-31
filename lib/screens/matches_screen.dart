import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'package:cwc2019_point_simulator/views/match_view.dart';
import 'package:cwc2019_point_simulator/models/match_card.dart';
import 'package:cwc2019_point_simulator/components//RoundIconButton.dart';
import 'point_table_screen.dart';

const String testDevice = '0B405E74F3EC5D1230D7AEAE9749D204';

class MatchesScreen extends StatefulWidget {
  static const String id = 'matches_screen';

  MatchesScreen();

  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final _firestore = Firestore.instance;
  bool _isLoading = false;
  List<MatchCard> matchCards = List<MatchCard>();

  static const String addUnitId = '';

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
//    keywords: <String>['foo', 'bar'],
//    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: /*BannerAd.testAdUnitId*/ addUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _isLoading = false;
    loadSampleDataToFireStore();

    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
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
      _bannerAd ??= createBannerAd();
      _bannerAd
        ..load()
        ..show(anchorOffset: 25.0, anchorType: AnchorType.top);
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 95.0),
                child: ListView.builder(
                  itemCount: matchCards.length,
                  itemBuilder: (context, index) {
                    return MatchView(
                      matchCard: matchCards[index],
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 40,
                right: 20,
                child: RoundIconButton(
                  icon: Icons.insert_chart,
                  onPress: () {
                    Navigator.pushNamed(context, PointTable.id);
                  },
                ),
              ),
              Positioned(
                bottom: 40,
                left: 20,
                child: RoundIconButton(
                  icon: Icons.delete,
                  onPress: () {
                    clearPrefs();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void loadSampleDataToFireStore() async {
    matchCards = await saveList();
    _isLoading = true;
    setState(() {});
  }

  Future<List<MatchCard>> saveList() async {
    Map<int, MatchCard> matchCards = Map<int, MatchCard>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final queryS =
        await Firestore.instance.collection('matchlist').getDocuments();

    queryS.documents.forEach((doc) {
      //print(doc.data['matchdata']);
      String matchDataString = doc.data['matchdata'];
      final decodedJson = json.decode(matchDataString);
      //print(decodedJson);
      for (var n in decodedJson) {
        MatchCard matchCard = MatchCard.fromMap(n);
        //print(matchCard.teamA);
        matchCards[matchCard.id] = matchCard;
      }
    });

    /**
     * set firebase already ran set a variable to prefs
     */
    Set<String> prefKeys = prefs.getKeys();
    for (var key in prefKeys) {
      if (key != null) {
        String getString = prefs.getString(key.toString());
        //print(getString);
        if (getString != null) {
          Map map = json.decode(getString);
          //print(map);
          MatchCard matchCard = MatchCard.fromMap(map);
          //print(matchCard.teamA);
          MatchCard fromInternet = matchCards[matchCard.id];
          if (fromInternet.completed /*&& matchCard.userEdited == 'true'*/) {
            //skip saving from shared prefs. since it is completed, should fetch from backend.
          } else {
            matchCards[matchCard.id] = matchCard;
          }
        }
      }
    }

    List<MatchCard> matchCardList = List<MatchCard>();
    matchCards.forEach((k, matchCard) {
      matchCardList.add(matchCard);

      /**
       * save all match cards to prefs
       */
      String json = jsonEncode(matchCard);
      prefs.setString(matchCard.id.toString(), json);
    });

    return matchCardList;
  }

  Future<void> clearPrefs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Set<String> prefKeys = prefs.getKeys();
      for (var key in prefKeys) {
        if (key != null) {
          String getString = prefs.getString(key.toString());
          //print(getString);
          if (getString != null) {
            Map map = json.decode(getString);
            //          print(map);
            MatchCard matchCard = MatchCard.fromMap(map);
            if (!matchCard.completed) {
              matchCard.Winner = "";
              matchCard.abandoned = '0';
              matchCard.tied = '0';
              matchCard.userEdited = 'false';
              String jsonToSave = jsonEncode(matchCard);
              prefs.setString(matchCard.id.toString(), jsonToSave);
            }
          }
        }
      }
      SystemNavigator.pop();
    } catch (e) {
      print(e);
    }
  }
}

/**
 * This class generated using the following AndroidStudio plugin
 * //https://github.com/neverwoodsS/idea_dart_json_format
 * new DartFile -> right click -> click generate -> paste json on popup -> ok
 */

/// teamAOvers : "50"
/// tied : "0"
/// teamAScore : "311"
/// teamBOvers : "39.5"
/// completed : true
/// teamAWickets : "8"
/// teamBWickets : "10"
/// teamBScore : "207"
/// Winner : "England"
/// teamA : "England"
/// teamB : "South Africa "
/// id : "1"
/// abandoned : "0"
/// firstBat : "England"
/// userEdited : "false"

class MatchCard {
  String teamAOvers;
  String tied;
  String teamAScore;
  String teamBOvers;
  bool completed;
  String teamAWickets;
  String teamBWickets;
  String teamBScore;
  String Winner;
  String teamA;
  String teamB;
  int id;
  String abandoned;
  String firstBat;
  String teamABalls;
  String teamBBalls;
  String userEdited;
  String venue;
  String date;

  static MatchCard fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MatchCard matchCardBean = MatchCard();
    matchCardBean.teamAOvers = map['teamAOvers'];
    matchCardBean.tied = map['tied'];
    matchCardBean.teamAScore = map['teamAScore'];
    matchCardBean.teamBOvers = map['teamBOvers'];
    matchCardBean.completed = map['completed'];
    matchCardBean.teamAWickets = map['teamAWickets'];
    matchCardBean.teamBWickets = map['teamBWickets'];
    matchCardBean.teamBScore = map['teamBScore'];
    matchCardBean.Winner = map['Winner'];
    matchCardBean.teamA = map['teamA'];
    matchCardBean.teamB = map['teamB'];
    matchCardBean.id = map['id'];
    matchCardBean.abandoned = map['abandoned'];
    matchCardBean.firstBat = map['firstBat'];
    matchCardBean.teamABalls = map['teamABalls'];
    matchCardBean.teamBBalls = map['teamBBalls'];
    matchCardBean.userEdited = map['userEdited'];
    matchCardBean.venue = map['venue'];
    matchCardBean.date = map['date'];
    return matchCardBean;
  }

  Map<String, dynamic> toJson() => {
        'teamAOvers': teamAOvers,
        'tied': tied,
        'teamAScore': teamAScore,
        'teamBOvers': teamBOvers,
        'completed': completed,
        'teamAWickets': teamAWickets,
        'teamBWickets': teamBWickets,
        'teamBScore': teamBScore,
        'Winner': Winner,
        'teamA': teamA,
        'teamB': teamB,
        'id': id,
        'abandoned': abandoned,
        'firstBat': firstBat,
        'teamABalls': teamABalls,
        'teamBBalls': teamBBalls,
        'userEdited': userEdited,
        'venue': venue,
        'date': date
      };
}

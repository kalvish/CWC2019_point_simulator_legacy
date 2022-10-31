/// Team : "New Zealand"
/// M : "2"
/// W : "2"
/// L : "0"
/// T : 0
/// N/R : "0"
/// PT : "4"
/// NRR : "2.279"
/// For : "385/63.2"
/// Against : "380/100.0"

class CountryPoints {
  String Team;
  int M = 0;
  int W = 0;
  int L = 0;
  int T = 0;
  int NR = 0;
  int PT = 0;
  double NRR = 0;
  String For;
  String Against;
  double scoreFor = 0;
  double oversFor = 0;
  double scoreAg = 0;
  double oversAg = 0;

  static CountryPoints fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CountryPoints countryPointsBean = CountryPoints();
    countryPointsBean.Team = map['Team'];
    countryPointsBean.M = map['M'];
    countryPointsBean.W = map['W'];
    countryPointsBean.L = map['L'];
    countryPointsBean.T = map['T'];
    countryPointsBean.NR = map['N/R'];
    countryPointsBean.PT = map['PT'];
    countryPointsBean.NRR = map['NRR'];
    countryPointsBean.For = map['For'];
    countryPointsBean.Against = map['Against'];
    return countryPointsBean;
  }

  Map<String, dynamic> toJson() => {
        'Team': Team,
        'M': M,
        'W': W,
        'L': L,
        'T': T,
        'N/R': NR,
        'PT': PT,
        'NRR': NRR,
        'For': For,
        'Against': Against
      };
}

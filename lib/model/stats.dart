

class Stats {
  final String startCityCode;
  final String endCityCode;
  final double temp;
  final double wind;
  final double precipitation;
  final DateTime startTime;

  Stats({
    required this.startCityCode,
    required this.endCityCode,
    required this.temp,
    required this.wind,
    required this.precipitation,
    required this.startTime,
  });

  //factory Stats.fromJson(Map<String, dynamic> json) => _$FlightDataFromJson(json);
  //Map<String, dynamic> toJson() => _$FlightDataToJson(this);
}

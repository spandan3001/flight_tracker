import 'package:latlong2/latlong.dart';

class Weather {
  final double temperature2m;
  final double precipitation;
  final double windSpeed10m;

  Weather({
    required this.temperature2m,
    required this.precipitation,
    required this.windSpeed10m,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {

    return Weather(
      temperature2m: json['temperature2m'],
      precipitation: json['precipitation'],
      windSpeed10m: json['windSpeed10m'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature2m': temperature2m,
      'precipitation': precipitation,
      'windSpeed10m': windSpeed10m,
    };
  }
}

class FlightData {
  final List<LatLng> path;
  final List<Weather> weather;

  FlightData({
    required this.path,
    required this.weather,
  });

  factory FlightData.fromJson(Map<String, dynamic> json) {
    return FlightData(
      path:
          List<LatLng>.from(json['path'].map((data) => LatLng(data[0].toDouble(), data[1].toDouble()))),
      weather: List<Weather>.from(
        json['weather'].map((data) => Weather.fromJson(data)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //'path': path.map((point) => point.toJson()).toList(),
      'path': path,
      'weather': weather.map((data) => data.toJson()).toList(),
    };
  }
}

Map<String,String> codes = {
  "SIN":"Singapore",
  "SYD":"Sydney",
  "IAH":"HUSTAN",
  "PHL":"philiphis"

} ;

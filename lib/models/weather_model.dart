class WeatherModel {
  final String time;
  final int interval;
  final double temperature2m;
  final double windSpeed10m;

  WeatherModel({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.windSpeed10m,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      time: json['current']['time'] ?? '',
      interval: json['current']['interval'] ?? 0,
      temperature2m: (json['current']['temperature_2m'] ?? 0.0).toDouble(),
      windSpeed10m: (json['current']['wind_speed_10m'] ?? 0.0).toDouble(),
    );
  }
}

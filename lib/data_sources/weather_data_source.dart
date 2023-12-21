import 'package:dio/dio.dart';

class WeatherDataSource {
  static Future<Response> fetchCurrentWeather(double lat, double long) async {
    final dio = Dio();
    return await dio.get(
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&current=temperature_2m,wind_speed_10m');
  }
}

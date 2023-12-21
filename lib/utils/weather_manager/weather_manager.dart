import 'package:dartz/dartz.dart';
import 'package:weather_app_error_handling/data_sources/weather_data_source.dart';
import 'package:weather_app_error_handling/models/weather_model.dart';
import 'package:weather_app_error_handling/utils/error_handler/error_handler.dart';

class WeatherManager {
  static Future<Either<ErrorState, WeatherModel>> fetchCurrentWeather(
      double lat, double long) async {
    return await ErrorHandler.callApi(
        () => WeatherDataSource.fetchCurrentWeather(lat, long), (result) {
      return WeatherModel.fromJson(result);
    });
  }
}

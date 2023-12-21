import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_app_error_handling/utils/enums.dart';

part 'error_state.dart';

class ErrorHandler {
  static Future<bool> _isConnected() async {
    var result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  static Future<Either<ErrorState, T>> callApi<T>(
      Future<Response> Function() api,
      T Function(dynamic) parse) async {
    try {
      final response = await api();
      switch (response.statusCode) {
        case 200:
          try {
            return right(parse(response.data));
          } catch (e) {
            return left(DataParseError(Exception(e.toString())));
          }
        case 401:
          return left(DataHttpError(HttpException.unAuthorized));
        case 500:
          return left(DataHttpError(HttpException.internalServerError));
        default:
          return left(DataHttpError(HttpException.unknown));
      }
    } on DioException catch (e) {
      if(!await _isConnected()) {
        return left(DataNetworkError(NetworkException.noInternetConnection));
      }
      return switch(e.type) {
        DioExceptionType.receiveTimeout =>
            left(DataNetworkError(NetworkException.timeOutError)),
        DioExceptionType.connectionTimeout =>
            left(DataNetworkError(NetworkException.timeOutError)),
        DioExceptionType.sendTimeout =>
            left(DataNetworkError(NetworkException.timeOutError)),
        _ => left(DataNetworkError(NetworkException.unknown)),
      };
    }
  }
}

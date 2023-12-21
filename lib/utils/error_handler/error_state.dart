part of 'error_handler.dart';

sealed class ErrorState<T> {
  final Exception? clientError;
  final Exception? parseError;
  final HttpException? httpError;
  final NetworkException? networkError;

  ErrorState({
    this.clientError,
    this.parseError,
    this.httpError,
    this.networkError,
  });
}

class DataClientError<T> extends ErrorState<T> {
  DataClientError(Exception error) : super(clientError: error) {
    log('DataClientError: client error captured!', error: error);
  }
}

class DataNetworkError<T> extends ErrorState<T> {
  DataNetworkError(NetworkException error) : super(networkError: error) {
    log('DataNetworkError: network error captured!', error: error);
  }
}

class DataHttpError<T> extends ErrorState<T> {
  DataHttpError(HttpException error) : super(httpError: error) {
    log('DataNetworkError: a HTTP error captured!', error: error);
  }
}

class DataParseError<T> extends ErrorState<T> {
  DataParseError(Exception error) : super(parseError: error) {
    log('DataParseError: Unable to parse the json!', error: error);
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_robinhood_siravit/core/utils/my_logger.dart';

class ApiService {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://todo-list-api-mfchjooefq-as.a.run.app/',
    ),
  )..interceptors.addAll(
      <Interceptor>[
        ErrorInterceptor(),
      ],
    );
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
      {
        'DIO':
            'Request: ${err.requestOptions.method} ${err.requestOptions.uri}',
        'BODY': '${err.requestOptions.data}',
        'HEADERS': err.requestOptions.headers,
        'DATA': '${err.response?.data}',
        'MESSAGE': err.message,
      },
      error:
          '[DIO] Response [code ${err.response?.statusCode}]: ${err.requestOptions.data}',
    );

    super.onError(err, handler);
  }
}

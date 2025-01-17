import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

import '../config/http_config.dart' as HttpConfig;

class HttpRequest {
  static BaseOptions _baseOptions = BaseOptions(connectTimeout: HttpConfig.TIMEOUT);

  static Future<Dio> _getDio() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var dio = Dio(_baseOptions);
    dio.interceptors.add(CookieManager(PersistCookieJar(dir: tempPath)));
    return dio;
  }

  static Future<T> request<T>(String url, {String method = "get", Map<String, dynamic> params}) async {
    Options options = Options();
    options.method = method;

    Dio dio = (await _getDio());
    try {
      Response response = await dio.request<T>(HttpConfig.BASE_URL + url,
          queryParameters: params, options: options);
      return response.data;
    } on DioError catch (e) {
      throw e;
    }
  }
}
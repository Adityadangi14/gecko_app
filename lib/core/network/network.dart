import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:geeko_app/core/network/request_params.dart';

class NetworkManager {
  Dio dio;

  NetworkManager({required this.dio});

  Future<Response> apiCall(
      {required String url,
      required ApiMethods requestType,
      Map<String, dynamic>? body,
      required Map<String, dynamic>? header}) async {
    try {
      log("${url} ${requestType} $body ${header.toString()}");
      switch (requestType) {
        case ApiMethods.get:
          return await dio.get(
            options: Options(headers: header),
            url,
          );
        case ApiMethods.post:
          return await dio.post(
            options: Options(headers: header),
            url,
            data: body,
          );
        case ApiMethods.put:
          return await dio.put(
            options: Options(headers: Header.header),
            url,
            data: body,
          );
        case ApiMethods.patch:
          return await dio.patch(
            options: Options(headers: Header.header),
            url,
            data: body,
          );
        case ApiMethods.delete:
          return await dio.delete(
            options: Options(headers: Header.header),
            url,
            data: body,
          );
        case ApiMethods.multipart:
        case ApiMethods.download:
          return await dio.get(url);
      }
    } on DioException {
      rethrow;
    }
  }
}

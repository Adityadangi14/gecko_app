import 'package:dio/dio.dart';
import 'package:geeko_app/core/network/token_singleton.dart';
import 'package:geeko_app/core/shared-prefrences/shared_prefrences_singleton.dart';

class RequestParams {
  final String url;
  final ApiMethods apiMethods;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? header;
  final String? filePath;
  final String? fileName;
  final ResponseType? responseType;

  const RequestParams(
      {required this.url,
      required this.apiMethods,
      this.body,
      required this.header,
      this.filePath,
      this.responseType,
      this.fileName});
}

enum ApiMethods { get, post, delete, put, patch, multipart, download }

class Header {
  static Map<String, String> header = {
    "Content-Type": "application/json",
    "Token": TokenSingleton.instance.token
  };
}

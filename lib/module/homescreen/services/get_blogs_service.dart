import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:geeko_app/core/data-state/data_state.dart';
import 'package:geeko_app/core/network/network.dart';
import 'package:geeko_app/core/network/request_params.dart';
import 'package:get/get.dart';

class GetBlogsService {
  NetworkManager networkManager = NetworkManager(dio: Dio());
  Future<DataState> getBlogsService(RequestParams requestParams) async {
    try {
      dio.Response response = await networkManager.apiCall(
          url: requestParams.url,
          requestType: requestParams.apiMethods,
          header: requestParams.header);

      if (response.statusCode == 200) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(Exception("Unable to get blogs."));
      }
    } catch (e) {
      rethrow;
    }
  }
}

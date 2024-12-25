import 'package:dio/dio.dart';
import 'package:geeko_app/core/data-state/data_state.dart';
import 'package:geeko_app/core/network/network.dart';
import 'package:geeko_app/core/network/request_params.dart';

class AuthService {
  NetworkManager networkManager = NetworkManager(dio: Dio());
  Future<DataState> authService(RequestParams requestParams) async {
    try {
      Response response = await networkManager.apiCall(
          url: requestParams.url,
          requestType: ApiMethods.post,
          body: requestParams.body,
          header: requestParams.header);

      if (response.statusCode == 200) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(Exception("Unable to authenticate."));
      }
    } catch (e) {
      rethrow;
    }
  }
}

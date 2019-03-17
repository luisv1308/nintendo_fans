import 'dart:async';
import 'package:nintendo_fans/services/abstract/i_store_service.dart';
import 'package:nintendo_fans/services/network_service.dart';
import 'package:nintendo_fans/services/network_service_response.dart';
import 'package:nintendo_fans/services/restclient.dart';

class StoreService extends NetworkService implements IStoreService {
  static const _NewsUrl = "http://phplaravel-175876-509694.cloudwaysapps.com/api/recentGames?page=1";
  dynamic meta;
  // static const _kUserOtpLogin = "/userotplogin";

  StoreService(RestClient rest) : super(rest);

  @override
  Future<NetworkServiceResponse<List<dynamic>>> allGames() async {
    var result = await rest.getAsync<List<dynamic>>(_NewsUrl);
    if (result.mappedResult != null) {
      var res = result.mappedResult;
      meta = result.metaLinks;

      return new NetworkServiceResponse(
        content: res,
        meta: meta,
        success: result.networkServiceResponse.success,
      );
    }
    return new NetworkServiceResponse(success: result.networkServiceResponse.success, message: result.networkServiceResponse.message);
  }

  Future<NetworkServiceResponse<List<dynamic>>> pageGames(url) async {
    var result = await rest.getAsync<List<dynamic>>(url);
    if (result.mappedResult != null) {
      var res = result.mappedResult;
      meta = result.metaLinks;

      return new NetworkServiceResponse(
        content: res,
        meta: meta,
        success: result.networkServiceResponse.success,
      );
    }
    return new NetworkServiceResponse(success: result.networkServiceResponse.success, message: result.networkServiceResponse.message);
  }

  Future<NetworkServiceResponse<Map<String, dynamic>>> userFavourite(String userId, String gameId) async {
    Map data = {'user_id': userId, 'game_id': gameId};
    var result = await rest.postAsync<List<dynamic>>('http://phplaravel-175876-509694.cloudwaysapps.com/api/favourite-create', data);
    if (result.mappedResult != null) {
      var res = result.mappedResult;
      meta = result.metaLinks;
      return new NetworkServiceResponse(
        content: res,
        meta: meta,
        success: result.networkServiceResponse.success,
      );
    }
    return new NetworkServiceResponse(success: result.networkServiceResponse.success, message: result.networkServiceResponse.message);
  }
}

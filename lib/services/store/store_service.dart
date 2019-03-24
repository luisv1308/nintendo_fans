import 'dart:async';

import 'package:nintendo_fans/services/abstract/i_store_service.dart';
import 'package:nintendo_fans/services/network_service.dart';
import 'package:nintendo_fans/services/network_service_response.dart';
import 'package:nintendo_fans/services/restclient.dart';
import 'package:nintendo_fans/utils/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoreService extends NetworkService implements IStoreService {
  dynamic meta;
  var userID;
  final storage = new FlutterSecureStorage();
  Constants _constants = new Constants();
  // static const _kUserOtpLogin = "/userotplogin";

  StoreService(RestClient rest) : super(rest);

  @override
  Future<NetworkServiceResponse<List<dynamic>>> allGames() async {
    var result = await rest.getAsync<List<dynamic>>(_constants.baseUrl + 'recentGames?page=1');
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

  Future<NetworkServiceResponse<List<dynamic>>> fullGames() async {
    var result = await rest.getAsync<List<dynamic>>(_constants.baseUrl + 'games');
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
    print(result.networkServiceResponse.message);
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
    var result = await rest.postAsync<List<dynamic>>(_constants.baseUrl + 'favourite-create', data);
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

  Future<NetworkServiceResponse<Map<String, dynamic>>> userDeleteFavourite(String userId, String gameId) async {
    Map data = {'user_id': userId, 'game_id': gameId};
    var result = await rest.deleteAsync<List<dynamic>>(_constants.baseUrl + 'favourite-delete', data);
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

  Future<NetworkServiceResponse<Map<String, dynamic>>> userRating(String gameId, double rating) async {
    this.userID = await storage.read(key: 'user_id');
    Map data = {'user_id': this.userID, 'game_id': gameId, 'rating': rating.toString()};
    var result = await rest.postAsync<List<dynamic>>(_constants.baseUrl + 'ratings-create', data);
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

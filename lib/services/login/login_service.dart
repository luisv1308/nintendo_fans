import 'dart:async';
import 'package:nintendo_fans/services/abstract/i_login_service.dart';
import 'package:nintendo_fans/services/network_service_login.dart';
import 'package:nintendo_fans/services/network_service_response.dart';
import 'package:nintendo_fans/services/restclientlogin.dart';

class LoginService extends NetworkServiceLogin implements ILoginService {
  static const _url = "http://phplaravel-175876-509694.cloudwaysapps.com/";
  dynamic meta;
  // static const _kUserOtpLogin = "/userotplogin";

  LoginService(RestClientLogin rest) : super(rest);

  @override
  Future<NetworkServiceResponse<Map<String, dynamic>>> login(String username, String password) async {
    Map data = {'username': username, 'password': password, 'grant_type': 'password', 'client_id': '2', 'client_secret': 'j5RBeLAd6DZx4eD1yjsXfqBMAaRTkuaehmlejd4B'};
    var result = await rest.postAsyncLogin<List<dynamic>>('http://phplaravel-175876-509694.cloudwaysapps.com/oauth/token', data);

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

  @override
  Future<NetworkServiceResponse<Map<String, dynamic>>> getUser() async {
    var result = await rest.getAsync<List<dynamic>>('http://phplaravel-175876-509694.cloudwaysapps.com/api/user');
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

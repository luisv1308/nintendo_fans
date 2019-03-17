import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nintendo_fans/services/network_service_response.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RestClient {
  final storage = new FlutterSecureStorage();

  Map<String, String> headers = {"CONTENT_TYPE": 'application/json', "ACCEPT": 'application/json', "Authorization": 'Bearer '};

  Future<MappedNetworkServiceResponse<T>> getAsync<T>(String resourcePath) async {
    final storage = new FlutterSecureStorage();
    String access_token = await storage.read(key: 'access_token');
    headers["Authorization"] += access_token;
    var response = await http.get(resourcePath, headers: headers);
    return processResponse<T>(response);
  }

  Future<MappedNetworkServiceResponse<T>> getAsyncXml<T>(String resourcePath) async {
    var response = await http.get(resourcePath);
    return processResponseXml<T>(response);
  }

  Future<MappedNetworkServiceResponse<T>> postAsync<T>(String resourcePath, dynamic data) async {
    var content = json.encoder.convert(data);
    final storage = new FlutterSecureStorage();
    String access_token = await storage.read(key: 'access_token');
    var headers = {"CONTENT_TYPE": 'application/json', "Authorization": "Bearer " + access_token};
    var response = await http.post(resourcePath, body: data, headers: headers);
    return processResponse<T>(response);
  }

  Future<MappedNetworkServiceResponse<T>> deleteAsync<T>(String resourcePath, dynamic data) async {
    var content = json.encoder.convert(data);
    final storage = new FlutterSecureStorage();
    String access_token = await storage.read(key: 'access_token');
    var headers = {"CONTENT_TYPE": 'application/json', "Authorization": "Bearer " + access_token, "X-HTTP-Method-Override": "DELETE"};
    var response = await http.post(resourcePath, body: data, headers: headers);
    return processResponse<T>(response);
  }

  MappedNetworkServiceResponse<T> processResponse<T>(http.Response response) {
    if (!((response.statusCode < 200) || (response.statusCode >= 300) || (response.body == null) || (response.body == ''))) {
      var jsonResult = response.body;
      var finalRes;
      var finalMeta;
      dynamic resultClass = jsonDecode(jsonResult);
      if (resultClass.containsKey("data")) {
        finalRes = resultClass["data"];
        finalMeta = resultClass["links"];
      } else {
        finalRes = resultClass;
        finalMeta = resultClass;
      }
      return new MappedNetworkServiceResponse<T>(mappedResult: finalRes, networkServiceResponse: new NetworkServiceResponse<T>(success: true), metaLinks: finalMeta);
    } else {
      var errorResponse = response.body;
      return new MappedNetworkServiceResponse<T>(networkServiceResponse: new NetworkServiceResponse<T>(success: false, message: "(${response.statusCode}) ${errorResponse.toString()}"));
    }
  }

  MappedNetworkServiceResponse<T> processResponseXml<T>(http.Response response) {
    if (!((response.statusCode < 200) || (response.statusCode >= 300) || (response.body == null))) {
      var result = response.body;
      dynamic resultClass = xml.parse(result);

      return new MappedNetworkServiceResponse<T>(mappedResult: resultClass, networkServiceResponse: new NetworkServiceResponse<T>(success: true));
    } else {
      var errorResponse = response.body;
      return new MappedNetworkServiceResponse<T>(networkServiceResponse: new NetworkServiceResponse<T>(success: false, message: "(${response.statusCode}) ${errorResponse.toString()}"));
    }
  }
}

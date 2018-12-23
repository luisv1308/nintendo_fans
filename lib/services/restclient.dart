import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nintendo_fans/services/network_service_response.dart';
import 'package:xml/xml.dart' as xml;

class RestClient {
  Map<String, String> headers = {
    "CONTENT_TYPE": 'application/json',
    "ACCEPT": 'application/json',
  };

  Future<MappedNetworkServiceResponse<T>> getAsync<T>(String resourcePath) async {
    var response = await http.get(resourcePath);
    return processResponse<T>(response);
  }

  Future<MappedNetworkServiceResponse<T>> getAsyncXml<T>(String resourcePath) async {
    var response = await http.get(resourcePath);
    return processResponseXml<T>(response);
  }

  Future<MappedNetworkServiceResponse<T>> postAsync<T>(String resourcePath, dynamic data) async {
    var content = json.encoder.convert(data);
    var response = await http.post(resourcePath, body: content, headers: headers);
    return processResponse<T>(response);
  }

  MappedNetworkServiceResponse<T> processResponse<T>(http.Response response) {
    if (!((response.statusCode < 200) || (response.statusCode >= 300) || (response.body == null))) {
      var jsonResult = response.body;
      dynamic resultClass = jsonDecode(jsonResult);

      return new MappedNetworkServiceResponse<T>(mappedResult: resultClass, networkServiceResponse: new NetworkServiceResponse<T>(success: true));
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

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nintendo_fans/services/network_service_response.dart';
import 'package:xml/xml.dart' as xml;

class RestClient {
  Map<String, String> headers = {
    "CONTENT_TYPE": 'application/json',
    "ACCEPT": 'application/json',
    "Authorization":
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjMyZTQyNGE0NjI5ZGRhNDQyYzkwNTZkNmQ2NTE5MjU3YmMxM2ZlYTIwMzc5YjhkNGMyNjI3MzhmYjg0ZmQ3ODk0NzE2NzdkODE5NTVlZjE1In0.eyJhdWQiOiIyIiwianRpIjoiMzJlNDI0YTQ2MjlkZGE0NDJjOTA1NmQ2ZDY1MTkyNTdiYzEzZmVhMjAzNzliOGQ0YzI2MjczOGZiODRmZDc4OTQ3MTY3N2Q4MTk1NWVmMTUiLCJpYXQiOjE1NDU4NzExMDEsIm5iZiI6MTU0NTg3MTEwMSwiZXhwIjoxNTc3NDA3MTAxLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.W0Z10m9SBeMjzkLfMIYZKqnC0VugKXwKaOmunofm-Y-Y-2n7gpKYjcKt1EU6QApzpnNyfFzRpmBW84MiV96gPgjcsZbDAHlVNGdjvye4J5UjSQoANlOYM_-sOMLSVbhU8AOutboIoh4JXRVAXMW10bqUWMYiKjEP41cRXEHx6vLpnBrPZU9r4QYQXOJHWZLwr-qKtM2rAa10Yq04rq5BIFDO6dwFRIlFvZ8sNftb3J-StBuwupcza1VroxrQNDz3lEuu4-nuTw0f_gAuoxoO8i-7JtGDdOzfjvM9QTl9A06xKuqw2qn414KVYzA8I4eBkp8dd0KUfzf2f-ceOIf3LTs1CptlczKKUptB_MT1JlZph_nLbRpSLNKKOXIMOoecSwl8KH2O_LUsIe3SBlbGzAqKoZf9FUcBbbtBPE9ISpYWPjMptf57meuMSE3zTHwKc1f516M_JEiM2UyAHIctmS2NHcpaK1NZ1Ujlm9-be3sjUTDL5DJB6FAuCFRQ8fko1Gz2sfjei0eXKuloDJRXhxRcmtjLvQuyz2iFTT76vV17aUiDgrucPIWsuBym2NPiboenGJVKwdsWoDTPrhSCp6dyW8s19kA-ya7bWQwWURHyo4qiVrmg_4ReUalEBLzfTVDgVl4T55YEVT_7T0l29M7g3fR6okZr_Nfs1rCVXss'
  };

  Future<MappedNetworkServiceResponse<T>> getAsync<T>(String resourcePath) async {
    var response = await http.get(resourcePath, headers: headers);
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

      return new MappedNetworkServiceResponse<T>(mappedResult: resultClass["data"], networkServiceResponse: new NetworkServiceResponse<T>(success: true));
    } else {
      var errorResponse = response.body;
      return new MappedNetworkServiceResponse<T>(networkServiceResponse: new NetworkServiceResponse<T>(success: false, message: "(${response.statusCode}) ${errorResponse.toString()}"));
    }
  }

  MappedNetworkServiceResponse<T> processResponseXml<T>(http.Response response) {
    if (!((response.statusCode < 200) || (response.statusCode >= 300) || (response.body == null))) {
      var result = response.body;
      dynamic resultClass = xml.parse(result);

      return new MappedNetworkServiceResponse<T>(mappedResult: resultClass["data"], networkServiceResponse: new NetworkServiceResponse<T>(success: true));
    } else {
      var errorResponse = response.body;
      return new MappedNetworkServiceResponse<T>(networkServiceResponse: new NetworkServiceResponse<T>(success: false, message: "(${response.statusCode}) ${errorResponse.toString()}"));
    }
  }
}

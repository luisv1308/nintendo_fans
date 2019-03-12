import 'dart:async';

import 'package:nintendo_fans/model/news.dart';
import 'package:nintendo_fans/services/abstract/i_news_service.dart';
import 'package:nintendo_fans/services/network_service.dart';
import 'package:nintendo_fans/services/network_service_response.dart';
import 'package:nintendo_fans/services/restclient.dart';
import 'package:xml/xml.dart';

class NewsService extends NetworkService implements INewsService {
  static const _NewsUrl = "http://www.nintendolife.com/feeds/latest";
  // static const _kUserOtpLogin = "/userotplogin";

  NewsService(RestClient rest) : super(rest);

  @override
  Future<NetworkServiceResponse<XmlDocument>> fetchStoreResponse() async {
    var result = await rest.getAsyncXml<XmlDocument>(_NewsUrl);

    if (result.mappedResult != null) {
      var res = result.mappedResult;
      // var titles = res.findAllElements('title');
      // titles.map((node) => node.text).forEach(print);
      // var reader = XmlReader(onStartElement: (name, attributes) => print(name));
      // reader.parse(res.toString());
      // print(res.XmlReader(onStartElement: (name, attributes) => print(name)));
      // print(res.toXmlString(pretty: true, indent: '\t'));
      return new NetworkServiceResponse(
        content: res,
        success: result.networkServiceResponse.success,
      );
    }
    return new NetworkServiceResponse(success: result.networkServiceResponse.success, message: result.networkServiceResponse.message);
  }
}
